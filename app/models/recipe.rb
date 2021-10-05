class Recipe < ApplicationRecord
    has_many :comments, dependent: :destroy

    belongs_to :user

    validates :title, presence: true

    has_many :likes, dependent: :destroy
    has_many :likers, through: :likes, source: :user

end
