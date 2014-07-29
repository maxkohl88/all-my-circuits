class UsersController < ApplicationController
  #check if the user is signed in when they visit the homepage
  before_action :authenticate_user!


  def index
    @users = User.search(search_params)
  end

  def new
    #empty new route for github authentication
  end

  def show
    @user = User.find(params[:id])
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
    params.require(:user).permit(:bday, :zip, :gender, :interested_in, :height,
                                 :fav_animal, :game_genre, :music_genre,
                                 :movie_genre, :human_language)
  end

  def user_params
    params.require(:user).permit(:bday, :zip, :gender, :interested_in, :height,
                                 :fav_animal, :game_genre, :music_genre,
                                 :movie_genre, :human_language, :summary,
                                 :fav_book, :industry, :years_programming,
                                 :primary_language)
  end


end
