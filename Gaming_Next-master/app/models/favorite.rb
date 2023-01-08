class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :game

  validates :game, :user, presence: true
  validates :game_id, uniqueness: { scope: :user_id, message: "is already favorited" }
end
