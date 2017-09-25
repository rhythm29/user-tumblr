# Model for user controller. It validates all the form fields presence and uniqueness.
class User < ApplicationRecord
  before_save :encrypt_password
  after_save :clear_password
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  validates :password,:presence =>true,:confirmation =>true
  validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
  validates_length_of :password, :in => 6..20, :on => :create
  
  # for storing encrypted password in DB uses a gem Bcrypt.
  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.password = BCrypt::Engine.hash_secret(password, self.salt)
    end
  end

  def clear_password
    self.password = nil
  end
  # for authenticating user compares entered values with values in database.
  def self.authenticate(username_or_email="", login_password="")
    if  EMAIL_REGEX.match(username_or_email)
      user = User.find_by_email(username_or_email)
    else
      user = User.find_by_username(username_or_email)
    end

    p user
    if user && user.match_password(login_password)
      return user
    else
      return false
    end
  end

  def match_password(login_password="")
    self.password == BCrypt::Engine.hash_secret(login_password, self.salt)
  end
end
