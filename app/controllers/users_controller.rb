class UsersController < ApplicationController
  #check if the user is signed in when they visit the homepage
  before_action :authenticate_user!


  def index
    @users = Users.search(search_params)
  end

  def new
    #empty new route for github authentication
  end

  def show
    @user = current_user
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
