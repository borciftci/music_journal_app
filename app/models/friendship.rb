class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  enum :status, values = { pending: 0, accepted: 1, declined: 2 }

  validates :user_id, uniqueness: { scope: :friend_id, message: "You have already added this friend." }

end
