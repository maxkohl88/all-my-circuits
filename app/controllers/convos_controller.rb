class ConvosController < ApplicationController

  def show
    # only show for current_user == u1_id || u2_id
  end

  def update
    # called with ajax when
    # 1) people submit text in the convo form
    # 2) people 'leave' or 'rejoin' the conversation
    # 3) 'block' the conversation (should also hude full profile)
  end

  def msgs
  end

  private

  def convo_params
    params.require(:convo).permit(:u1_id, :u2_id, :u1_response, :u2_response,
                                   :u1_present, :u2_present, :content, :blocked)
  end

end
