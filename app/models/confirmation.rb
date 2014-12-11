class Confirmation < ActiveRecord::Base
  belongs_to :user
  belongs_to :disaster
end
