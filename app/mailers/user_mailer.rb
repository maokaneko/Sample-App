class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user)
    @user = user # ユーザー情報をインスタンス変数に代入
    mail to: user.email, subject: "アカウントの有効化" # ユーザーのメールアドレスを引数に取り、メールを送信
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "パスワードの再設定"
  end
end
