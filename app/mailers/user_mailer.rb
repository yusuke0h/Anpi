class UserMailer < ActionMailer::Base
  default from: "take.five.mikaka@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.send_mail.subject
  #
  def send_mail user
    @user = user
    mail to: user.email
  end
end
