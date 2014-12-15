class User < ActiveRecord::Base
  has_many :confirmations
end
