# Preview all emails at http://localhost:3001/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3001/rails/mailers/user_mailer/account_activation
  def account_activation
    user = User.first # 最初のユーザーを取得
    user.activation_token = User.new_token # 有効化トークンを作成
    UserMailer.account_activation(user) # ユーザーのメールアドレスを引数に取り、メールを送信
  end

  # Preview this email at http://localhost:3001/rails/mailers/user_mailer/password_reset
  def password_reset
    user = User.first 
    user.reset_token = User.new_token
    UserMailer.password_reset(user)
  end

end
