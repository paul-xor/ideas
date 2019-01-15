class User < ApplicationRecord
    has_many :ideas
    has_secure_password
    before_save { self.email = email.downcase }

    validates :username, presence: true, uniqueness: { case_sensitive: false }, 
    length: { minimum: 3, maximum: 15}
    
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 100 },
    uniqueness: { case_sensitive: false }, 
    format: { with: VALID_EMAIL_REGEX}
    
end