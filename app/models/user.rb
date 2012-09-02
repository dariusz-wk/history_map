class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :permissions
  has_secure_password

  before_save do |user|
    user.email = email.downcase
    if(user.permissions.nil?)
      user.permissions = 1
    end
  end

  before_save :create_remember_token

  validates :name, :presence => true, :length => { :maximum => 50 },
  :uniqueness => { :case_sensitive => false }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => true,
  :format => { :with => VALID_EMAIL_REGEX },
  :uniqueness => { :case_sensitive => false }
  validates :password, :presence => true, :length => { :minimum => 5 }
  validates :password_confirmation, :presence => true


  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end