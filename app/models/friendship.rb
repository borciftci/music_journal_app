class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"
  validates :friend_id, presence: true
  validate :cannot_add_self

  enum :status, values = { pending: 0, accepted: 1, declined: 2 }

  validates :user_id, uniqueness: { scope: :friend_id, message: "You have already added this friend." }

  def cannot_add_self
    errors.add(:friend_id, "You cannot add yourself as a friend") if user_id == friend_id
  end
end
