class User < ActiveRecord::Base
  has_many :wods
  has_secure_password
  #Adds methods to set and authenticate against a BCrypt password. This mechanism requires you to have a password_digest attribute.
  #Automatically adds validations of, Password must be present on creation, Password length <= 72 char, Confirmation of password (using a password_confirmation attribute.)
  validates :username, uniqueness: true
  validates :username, presence: true

  def slug
    username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end

end
