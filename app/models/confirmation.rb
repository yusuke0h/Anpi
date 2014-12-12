class Confirmation < ActiveRecord::Base
  belongs_to :user
  belongs_to :disaster

  def self.auto_create disaster_id
    User.all.each do |user|
      @confirmation = Confirmation.create(user_id: user.id, disaster_id: disaster_id)
    end
  end

end
