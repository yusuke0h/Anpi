class Disaster < ActiveRecord::Base
  has_many :confirmations

  def self.api_check
  end

  def send_mail_to_unanswered_users
    case Rails.env
    when 'development'
      server_name = "localhost:3000"
    else
      server_name = "https://anpi201412.herokuapp.com"
    end
    self.confirmations.where(contacted: false).map { |e| e.user }.each do |user|
      encrypt_user_id = encrypt user.id
      conf_edit_url = server_name + Rails.application.routes.url_helpers.disaster_confirmations_edit_path(self) + "?user_id=" + encrypt_user_id
      user_conf_url = server_name + Rails.application.routes.url_helpers.disaster_confirmations_index_for_user_path(self)

      mail = UserMailer.send_mail user, conf_edit_url, user_conf_url
      mail.transport_encoding = '8bit'
      mail.deliver
    end
  end

  def self.atuo_send_mail_to_unanswered_users
    Disaster.where(created_at: [1.hours.ago..Time.now]).each do |disaster|
      disaster.send_mail_to_unanswered_users
    end
  end

  private

  def encrypt user_id
    encryptor = ::ActiveSupport::MessageEncryptor.new('5793f0e2787753306b54256b7e72dac616c3a6ea87c65efa5777dca984e154419e844d0a541408f8e8364773342097d358f9', cipher: 'aes-256-cbc')
    encryptor.encrypt_and_sign(user_id)
  end

end
