class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :age, :height, :primary_language, :human_language,
             :years_programming, :industry, :fav_book, :fav_animal,
             :game_genre, :movie_genre, :music_genre, :summary,
             :profile_picture_url


  def age
    ((Date.today - object.bday).to_i / 365)
  end
end
