class Article < ApplicationRecord
    belongs_to :user
    has_many :article_categories
    has_many :categories, through: :article_categories
    validates :title, presence: true, length: {minimum: 5, maximum:20}
    validates :body, presence: true, length: {minimum: 25, maximum: 600}
end
