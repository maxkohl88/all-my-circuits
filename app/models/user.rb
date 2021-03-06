class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :chats1, foreign_key: :u1_id, class_name: 'Chat', dependent: :destroy
  has_many :chats2, foreign_key: :u2_id, class_name: 'Chat', dependent: :destroy
  has_many :messages

  SEARCHABLE = [:zip, :gender, :interested_in,
                :game_genre, :music_genre, :movie_genre, :human_language]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         :omniauth_providers => [:github]

  LANGUAGES = {
  c: 'http://jtmgroup.in/images/arch-C_logo.png',
  java: 'http://nowthatiseasy.com/wp-content/uploads/2012/09/java-logo-large-500x500-370x330.png',
  javascript: 'http://webwalker.to/show/Lib/images/logo-javascript.jpg',
  perl: 'http://mike.anobile.info/wp-content/uploads/2012/10/perl_logo.jpg',
  python: 'http://softwarespk.com/wp-content/uploads/2014/01/Download-Python-3.3.3-Full-Version.jpg?d1a4dd',
  ruby: 'assets/language-logos/ruby-logo.png'
}

  validates :name, :bday, :zip, :gender, :interested_in, :height, :summary,
  presence: true, if: :active_or_basic?

  validates :fav_animal, :fav_book, :game_genre, :music_genre, :movie_genre,
  presence: true, if: :active_or_favorite?

  validates :primary_language, :human_language, :industry,
  presence: true, if: :active_or_non_searchable?

  def been_liked(curr_user)

    self.chats2.each do |chat|
      if chat.u1_id == curr_user.id
        return true
      end
    end
    false
  end

  def active?
    status == 'active'
  end

  def active_or_basic?
    self.status.include?('basic') || active?
  end

  def active_or_favorite?
    status.include?('favorite') || active?
  end

  def active_or_non_searchable?
    status.include?('developer') || active?
  end

  # check if the user has been created in the system yet, and if they have not
  # then create a new instance of user for them. this method checks for existence
  # of the user based on their :provide and their :uid. neat!
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.status = 'inactive'
      user.profile_picture_url = auth.info.image.split('?')[0]
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.github_data"] && session["devise.github_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end


end

