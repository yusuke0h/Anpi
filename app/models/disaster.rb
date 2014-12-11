class Disaster < ActiveRecord::Base
  has_many :bundle_mails
  has_many :confirmations
end
