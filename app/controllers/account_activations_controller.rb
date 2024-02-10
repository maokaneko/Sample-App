class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate # アカウントを有効化
      log_in user
      flash[:success] = "アカウントが有効化されました！"
      redirect_to user
    else
      flash[:danger] = "アカウントの有効化に失敗しました。"
      redirect_to root_url
    end
  end
end
