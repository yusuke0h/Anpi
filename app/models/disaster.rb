class Disaster < ActiveRecord::Base
  has_many :confirmations
end
