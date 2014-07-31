class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :age, :height, :primary_language, :human_language,
             :years_programming, :industry, :fav_book, :fav_animal,
             :game_genre, :movie_genre, :music_genre, :summary,
             :profile_picture_url, :been_liked, :default_pic

  def age
    ((Date.today - object.bday).to_i / 365)
  end

  def been_liked
    object.chats2.each do |chat|
      if chat.u1_id == current_user.id
        return true
      end
    end
    false
  end

  def default_pic
    User::LANGUAGES[object.primary_language.to_sym]
  end
end
