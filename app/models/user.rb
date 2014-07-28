class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         :omniauth_providers => [:github]


   validates :name, :bday, :zip, :gender, :interested_in, :height, :summary,
   presence: true

  #validate that the name has at least 3 characters
  # validates :name, length: {minimum: 3}

  #validate that the bday format is correct
  # validates :bday, format:
  #  { :with => /[1-2]{1}[0-9]{3}\/[0-1]{1}[0-9]{1}\/[0-3]{1}[0-9]{1}/ }

  # check if the user has been created in the system yet, and if they have not
  # then create a new instance of user for them. this method checks for existence
  # of the user based on their :provide and their :uid. neat!
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      # user.image = auth.info.image
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
