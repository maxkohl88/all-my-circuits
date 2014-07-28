class MoveAttrOntoUser < ActiveRecord::Migration
  def up
    add_column :users, :bday, :date
    add_column :users, :zip, :text
    add_column :users, :gender, :text
    add_column :users, :interested_in, :text
    add_column :users, :height, :integer
    add_column :users, :primary_language, :text
    add_column :users, :human_language, :text
    add_column :users, :years_programming, :integer
    add_column :users, :industry, :text
    add_column :users, :fav_animal, :text
    add_column :users, :fav_book, :text
    add_column :users, :game_genre, :text
    add_column :users, :music_genre, :text
    add_column :users, :movie_genre, :text
    add_column :users, :summary, :text
    add_column :users, :profile_picture_url, :text
  end
  def down
    remove_column :users, :bday, :date
    remove_column :users, :zip, :text
    remove_column :users, :gender, :text
    remove_column :users, :interested_in, :text
    remove_column :users, :height, :integer
    remove_column :users, :primary_language, :text
    remove_column :users, :human_language, :text
    remove_column :users, :years_programming, :integer
    remove_column :users, :industry, :text
    remove_column :users, :fav_animal, :text
    remove_column :users, :fav_book, :text
    remove_column :users, :game_genre, :text
    remove_column :users, :music_genre, :text
    remove_column :users, :movie_genre, :text
  end
end
