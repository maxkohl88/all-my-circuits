class Chat < ActiveRecord::Base
  # has_many :messages
  belongs_to :u1, class_name: 'User'
  belongs_to :u2, class_name: 'User'
  has_many :messages

  def other_user(current_user)
    if current_user.id == self.u1_id
      return User.find(self.u2_id)
    else
      return User.find(self.u1_id)
    end
  end


end
