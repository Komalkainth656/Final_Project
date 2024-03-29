class User < ApplicationRecord
    has_secure_password
    has_many :recipes
    has_many :comments

    has_many :likes, dependent: :destroy
    has_many :liked_recipes, through: :likes, source: :recipe

    validates :email, presence: true, uniqueness: true,
    format:  /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

    def full_name
        "#{first_name} #{last_name}"
      end
end
