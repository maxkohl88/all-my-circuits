class UsersController < ApplicationController
  #check if the user is signed in when they visit the homepage
  before_action :authenticate_user!


  def index
    # if no search terms, search gender + interested_in
    # Special cases for 'both'
    if current_user.interested_in == 'both'
      @users = User.where(interested_in: current_user.gender || 'both')
    else
      @users = User.where(gender: current_user.interested_in,
                        interested_in: current_user.gender || 'both')
    end
    # if search terms, compound search with each term's value
    # looks like it will work if search options are submitted through params
    User::SEARCHABLE.each do |term|
      if params[term]
        @users = @users.select { |user| user[term] == params[term] }
      end
    end
    binding.pry
  end


  def new
    #empty new route for github authentication
  end

  def show
    @user = User.find(params[:id])
  end

  def update
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:bday, :zip, :gender, :interested_in, :height,
                                 :fav_animal, :game_genre, :music_genre,
                                 :movie_genre, :human_language, :summary,
                                 :fav_book, :industry, :years_programming,
                                 :primary_language)
  end

end
