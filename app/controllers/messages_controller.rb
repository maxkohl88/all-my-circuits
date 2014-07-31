class MessagesController < ApplicationController

  respond_to :json

  def default_serializer_options
    {root: false}
  end

  def index
    respond_with @messages = Chat.find(params[:chat_id]).messages
  end

  def create
    @msg = current_user.messages.new(messages_params)
    if current_user.save
      render json: @msg
      return
    else
      raise "Something went wrong sending the message"
    end
  end

  private

  def messages_params
    params.require(:message).permit(:content, :user_id, :chat_id)
  end

end
