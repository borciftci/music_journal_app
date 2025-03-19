class MusicLog < ApplicationRecord
  belongs_to :user

  GENRES = %w[Pop Hip-Hop Electronic Soul Rock Jazz Classical Reggae Country]

  validates :song_name, presence: true
  validates :artist, presence: true
  validates :mood, presence: true
  validates :date, presence: true
  validates :genre, inclusion: { in: GENRES, message: "%{value} is not a valid genre" }
end
