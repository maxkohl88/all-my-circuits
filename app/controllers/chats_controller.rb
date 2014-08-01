class ChatsController < ApplicationController


  def default_serializer_options
    {root: false}
  end

  respond_to :json, :html

  def index
    @chats = current_user.chats1
    @chats += current_user.chats2
    @chats = @chats.select do |chat|
      ((chat.u1_like == true) &&
       (chat.u2_like == true) &&
       (chat.blocked == false))
    end
  end

  def find_or_create
    @chat =  Chat.where(u1: chats_params[:u2], u2: current_user.id)[0]
    @chat2 = Chat.where(u2: chats_params[:u2], u1: current_user.id)[0]
    theChat = @chat
    if @chat
      if !@chat.u2_like
        @chat.update(u2_like: true)
      else
        puts 'chat exists already, cant like twice'
      end
    elsif @chat2
      theChat = @chat2
      puts 'Chat exists already, user cant like twice'
    else
      if current_user.id == chats_params[:u2]
        theChat = Chat.create(u1_id: current_user.id,
                              u2_id: chats_params[:u2],
                              blocked: true)
      else
        theChat = Chat.create(u1_id: current_user.id,
                              u2_id: chats_params[:u2],
                              u1_like: true)
      end
    end
    # responding with something serialized so it doesn't look for a template
    respond_with theChat
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
    @chat = Chat.find(params[:id])
    @chat.delete
    # responding with something serialized so it doesn't look for a template
    respond_with @chat
  end

  def update
    @chat = Chat.find(params[:id])
    @chat.update(chats_params)
    # responding with something serialized so it doesn't look for a template
    respond_with @chat
  end


  private

  def chats_params
    params.require(:chat).permit(:ul, :u2, :u1_like, :u2_like, :blocked)
  end

end
