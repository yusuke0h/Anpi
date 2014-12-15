# encoding: utf-8

class Disaster < ActiveRecord::Base
  has_many :confirmations

  def self.api_check
    require 'open-uri'
    now_time = Time.now
    now_time_st = now_time.strftime("%Y-%m-%d%%20%H:%M:%S")
    # now_plus_five_time_st = (now_time - 5.minutes).strftime("%Y-%m-%d%%20%H:%M:%S")
    now_plus_five_time_st = (now_time - 5.month).strftime("%Y-%m-%d%%20%H:%M:%S")
    api_path = "http://api.aitc.jp/jmardb-api/search?datetime=#{now_plus_five_time_st}&datetime=#{now_time_st}&limit=100&order=new&headtitle=%E9%9C%87%E5%BA%A6%E9%80%9F%E5%A0%B1&path=/report/body/intensity/observation/pref"
    json_data = JSON.parse(open(api_path).read)

    is_big_earthquake = false
    max_maxint = 0
    max_maxint_st = ""
    headline = ""
    area = ""
    time = ""
    json_data["data"].each do |data_element|
      data_element["fragment"].each do |frag_element|
        frag_element["area"].each do |area_element|
          maxInt = area_element["maxInt"]
          if maxInt == "6-" || maxInt == "6+" || maxInt == "7"
            case maxInt
            when "6-"
              max_int = 8
            when "6+"
              max_int = 9
            when "7"
              max_int = 10
            end
            if max_int > max_maxint
              max_maxint = max_int
              max_maxint_st = maxInt
              headline = data_element["headline"]
              area = area_element["name"]
              time = data_element["datetime"]
            end
            is_big_earthquake = true
          end
        end
      end
    end

    year, month, day = time[0..9].split("-").take(3)
    if is_big_earthquake
      disaster = Disaster.new(name: "#{time[0..9].to_s}<br>#{area} 地方地震", description: "#{headline}<br>発生時刻：#{time.to_s}<br>最大震度 : #{max_maxint_st}<br>地域：#{area}<br>")
      disaster.save
      Confirmation.auto_create(disaster.id)
      disaster.send_mail_to_unanswered_users
    end

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

      mail = UserMailer.send_mail self, user, conf_edit_url, user_conf_url
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
