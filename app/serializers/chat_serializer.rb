class ChatSerializer < ActiveModel::Serializer
  attributes :u1_id, :u2_id, :u1_like, :u2_like, :blocked
end
