class MessagesController < ApplicationController

  respond_to :json

  def default_serializer_options
    {root: false}
  end

  def index
    respond_with @messages = Chat.find(params[:chat_id]).messages
  end

  def create
  end

  private

  def messages_params
    params.require(:message).permit(:content, :user, :chat)
  end

end
