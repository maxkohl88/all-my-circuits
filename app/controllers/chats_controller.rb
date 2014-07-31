class ChatsController < ApplicationController

  def index
  end

  def find_or_create
    @chat =  Chat.where(u1: chats_params[:u2], u2: current_user.id)
    @chat2 = Chat.where(u2: chats_params[:u2], u1: current_user.id)
    if @chat != []
      if !@chat.u2_like
        @chat.update(@chat, u2_like: true)
      else
        puts 'chat exists already, cant like twice'
      end
    elsif @chat2 != []
      puts 'Chat exists already, user cant like twice'
    else
      chat = Chat.create(u1: current_user.id, u2: chats_params[:u2], u1_like: true)
    end
  end

  def matches
    @waiting_matches = current_user.chats1.where(u2_like: false)
    @initiated_matches = current_user.chats1.select do |chat|
      ((chat.u2_like == true) &&
      (chat.u1_like == true) &&
      (chat.blocked == false))
    end
    @joined_matches = current_user.chats2.select do |chat|
      ((chat.u2_like == true) &&
      (chat.u1_like == true) &&
      (chat.blocked == false))
    end
  end

  def create
  end

  def destroy
  end

  def update
  end


  private

  def chats_params
    params.require(:chat).permit(:ul, :u2, :u1_like, :u2_like, :blocked)
  end

end
