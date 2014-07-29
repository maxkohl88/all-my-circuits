# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
20.times do |i|
  gender = 'female'
  interest = 'male'
  if i%2 == 0
    interest = 'female'
    gender = 'male'
  end

  User.create!(email: Faker::Internet.safe_email, password: Faker::Internet.password,
               provider: 'github', uid: 10101010, name: "user #{i}", bday: '1990-01-01',
               zip: 10024, gender: gender, interested_in: interest, height: 70, primary_language: 'c++',
               human_language: 'English', years_programming: i, industry: 'web',
               fav_animal: 'wombat', fav_book: 'catcher', game_genre: 'RPG', music_genre: 'rock',
               movie_genre: 'Horror', status: 'active', summary: 'Yoyo')
  puts "made user #{i}"

  User.create!(email: Faker::Internet.safe_email, password: Faker::Internet.password,
               provider: 'github', uid: 10101010, name: "user #{i}.2", bday: '1990-01-01',
               zip: 10024, gender: gender, interested_in: interest, height: 70, primary_language: 'c++',
               human_language: 'English', years_programming: i, industry: 'web',
               fav_animal: 'wombat', fav_book: 'catcher', game_genre: 'RPG', music_genre: 'rock',
               movie_genre: 'Action', status: 'active', summary: 'Yoyo')
  puts "made user #{i}--2"
end
