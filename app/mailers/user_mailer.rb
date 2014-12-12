# encoding: utf-8

class UserMailer < ActionMailer::Base
  default from: "take.five.mikaka@gmail.com"

  # case Rails.env
  # when 'production'
  #   DOMAIN_NAME = 'anpi201412.herokuapp.com'
  #   HOST_NAME = "https://" + SafetyConfirmation::Application.config.action_mailer.default_url_options[:host]
  # else
  #   DOMAIN_NAME = 'localhost'
  #   HOST_NAME = SafetyConfirmation::Application.config.action_mailer.default_url_options[:host]
  # end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.send_mail.subject
  #
  def send_mail user, conf_edit_url, user_conf_url
    @user = user
    @conf_edit_url = conf_edit_url
    @user_conf_url = user_conf_url
    mail to: user.email, subject: '災害が発生しました.安否登録をしてください'
  end
end
