class Disaster < ActiveRecord::Base
  has_many :confirmations

  def self.api_check
  end
end
