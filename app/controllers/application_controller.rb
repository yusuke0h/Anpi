class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def encrypt user_id
    encryptor = ::ActiveSupport::MessageEncryptor.new('5793f0e2787753306b54256b7e72dac616c3a6ea87c65efa5777dca984e154419e844d0a541408f8e8364773342097d358f9', cipher: 'aes-256-cbc')
    encryptor.encrypt_and_sign(user_id)
  end

  def decrypt user_id
    encryptor = ::ActiveSupport::MessageEncryptor.new('5793f0e2787753306b54256b7e72dac616c3a6ea87c65efa5777dca984e154419e844d0a541408f8e8364773342097d358f9', cipher: 'aes-256-cbc')
    encryptor.decrypt_and_verify(user_id)
  end

end
