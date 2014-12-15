class User < ActiveRecord::Base
  has_many :confirmations

  def self.outside_update
    OutsideUser.all. each do |ouser|
      if User.where(id: ouser.id).first
        user = User.find ouser.id
        user.update(name: ouser.name, email: ouser.email, tel: ouser.tel)
      else
        User.create(name: ouser.name, email: ouser.email, tel: ouser.tel)
      end
    end

    User.all.each do |user|
      unless OutsideUser.where(id: user.id).first
        user.destroy
      end
    end

  end
end
