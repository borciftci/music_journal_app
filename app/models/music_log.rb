class MusicLog < ApplicationRecord
  belongs_to :user

  scope :favorites, -> { where(favorite: true) }
  GENRES = %w[Pop Hip-Hop Electronic Soul Rock Jazz Classical Reggae Country]

  validates :genre, inclusion: { in: GENRES, message: "%{value} is not a valid genre" }
end
