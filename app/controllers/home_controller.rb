class HomeController < ApplicationController

  def show
    if user_signed_in?
      redirect_to user_path(current_user.id)
    end
  end

end
