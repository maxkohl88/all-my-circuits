class MessageSerializer < ActiveModel::Serializer
  attributes :user_sent, :content, :formatted_time

  def user_sent
    (object.user_id == current_user.id)
  end

  def formatted_time
    (object.created_at).strftime("%B %d, '%y \n %I:%M %p")
  end

end
