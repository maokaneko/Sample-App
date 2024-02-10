class PasswordResetsController < ApplicationController
  before_action :get_user,          only: [:edit, :update]
  before_action :valid_user,        only: [:edit, :update] # 有効なユーザーかどうか確認
  before_action :check_expiration,  only: [:edit, :update] # トークンが期限切れかどうか確認

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "パスワード再設定のためのメールアドレスを送りました。"
      redirect_to root_url
    else
      flash.now[:danger] = "メールアドレスが見つかりません。"
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty? # パスワードが空文字列になっていないか確認
      @user.errors.add(:password, "パスワードを入力してください。")
      render 'edit', status: :unprocessable_entity
    elsif @user.update(user_params) # パスワードが正しければ更新
      reset_session
      log_in @user
      flash[:success] = "パスワードがリセットされました。"
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity # 無効なパスワードであれば失敗させる
    end
  end



  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
      @user = User.find_by(email: params[:email]) # メールアドレスからユーザーを取得
    end

    # 正しいユーザーかどうか確認する
    def valid_user
      unless (@user && @user.activated? &&
              @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end

  # トークンが期限切れかどうか確認する
    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "期限切れです。再度パスワード再設定を行ってください"
        redirect_to new_password_reset_url
      end
    end
end
