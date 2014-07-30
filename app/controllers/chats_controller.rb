class ChatsController < ApplicationController

  def index
  end

  def find_or_create
    @chat =  Chat.where(u1: chats_params[:u2], u2: current_user.id)
    @chat2 = Chat.where(u2: chats_params[:u2], u1: current_user.id)
    if @chat != []
      @chat.update(@chat, u2_like: true)
    elsif @chat2 != []
      puts 'Chat exists already, user cant like twice'
    else
      chat = Chat.create(u1: current_user.id, u2: chats_params[:u2], u1_like: true)
    end
    redirect_to :back
  end

  def create
  end

  def destroy
  end

  def update
  end

  def matches
  end

  private

  def chats_params
    params.require(:chat).permit(:ul, :u2, :u1_like, :u2_like, :blocked)
  end

end
