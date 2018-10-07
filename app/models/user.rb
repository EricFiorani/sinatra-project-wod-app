class User < ActiveRecord::Base
  has_many :wods
  has_secure_password
  # This ActiveRecord macro gives us access to a few
  # new methods. A macro is a method that when called, creates methods for you.
  # is being called just like a normal ruby method. It works in conjunction with
  # a gem called bcrypt and gives us all of those abilities in a secure way that
  # DOESNT ACTUALLY STORE THE PLAIN TEXT PASSWORD IN THE DATABASE.
  validates :username, uniqueness: true
  #This helper validates that the attribute's value is unique right before the object gets saved.
  validates :username, presence: true
  #This helper validates that the specified attributes are not empty.

  def slug
    #We can't have spaces in a URL. In order to make it a proper URL, we have
    # to convert the spaces to - in the name. This is called a slug.
    #A slug is used to create a name that is not acceptable as a URL
    # for various reasons (special characters, spaces, etc).
    username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end

end
