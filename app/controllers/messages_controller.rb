class MessagesController < ApplicationController

  def index
  end

  def create
  end

  private

  def messages_params
    params.require(:message).permit(:content, :user, :chat)

end
