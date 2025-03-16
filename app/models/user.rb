class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :music_logs, dependent: :destroy
  has_many :friendships
  has_many :pending_friendships, -> { where status: "pending" }, class_name: "Friendship", foreign_key: "friend_id"
  has_many :friends, -> { where(friendships: { status: "accepted" }) }, through: :friendships, source: :friend

  has_one :favorite_song, class_name: "MusicLog", primary_key: "favorite_song_id", foreign_key: "id", required: false

  validates :username, presence: true, uniqueness: { case_sensitive: false }

  before_save { self.username = username.downcase if username.present? }
end
