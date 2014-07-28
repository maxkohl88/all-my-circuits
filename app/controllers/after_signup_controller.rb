class AfterSignupController < Wicked::WizardController
  before_filter :authenticate_user!

  steps :basic_info, :summary, :searchable_details, :non_searchable_details

  def show
    @user = current_user
    render_wizard
  end

  def update
    @user = current_user
    @user.update_attributes(wizard_params)
    render_wizard @user
  end

  private

  def wizard_params
    params.require(:user).permit(:name, :bday, :zip, :gender, :interested_in,
    :height, :primary_language, :human_language, :years_programming, :industry,
    :fav_animal, :fav_book, :game_genre, :music_genre, :movie_genre)
  end

end
