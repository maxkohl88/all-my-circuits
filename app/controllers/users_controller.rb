class UsersController < ApplicationController

  def index
    @users = Users.search(search_params)
  end

  # self.search function on the user model

  def update
  end

  def destroy
  end

  def preferences
    #colorscheme
    #destroy
  end


  private

  def search_params
    params.require(:user).permit(:essentials, :searchable)
  end

  def user_params
    params.require(:user).permit(:essentials, :summary, :personal, :searchable)
  end


end
