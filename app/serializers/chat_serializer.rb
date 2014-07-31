class ChatSerializer < ActiveModel::Serializer
  attributes :ul_id, :u2_id, :u1_like, :u2_like, :blocked
end
