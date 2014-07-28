class AfterSignupController < Wicked::WizardController
  before_filter :authenticate_user!

  steps :basic_info, :summary, :favorite_details, :non_searchable_details

  def show
    @user = current_user

    if @user.sign_in_count > 1
      redirect_to user_path(@user.id)
    else
      render_wizard
    end
  end

  def update
    @user = current_user
    params[:user][:status] = step.to_s
    params[:user][:status] = 'active' if step == steps.last
    @user.update_attributes(wizard_params)
    render_wizard @user
  end

  private

  def wizard_params
    params.require(:user).permit(:name, :bday, :zip, :gender, :interested_in,
    :height, :primary_language, :human_language, :years_programming, :industry,
    :summary, :fav_animal, :fav_book, :game_genre, :music_genre, :movie_genre,
    :status)
  end

end
