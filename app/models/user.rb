class User < ApplicationRecord
    before_save{ self.email = email.downcase }    
    has_many :articles, dependent: :destroy
    validates :username, presence: true,
                            uniqueness: {case_sensitive: false},
                            length: {minimum: 3, maximum:15}

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :email, presence: true,
                        uniqueness: {case_sensitive: false},
                        format: {with: VALID_EMAIL_REGEX}

    validates :password, presence: true, length: {minimum: 6, maximum: 20}
    has_secure_password
    self.per_page = 5
    has_one_attached :image do |attachable|
        attachable.variant :thumb, resize_to_limit: [200, 200]
    end
    
end