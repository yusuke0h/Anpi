class User < ActiveRecord::Base
  has_many :confirmations

  def self.outside_update
  end
end
