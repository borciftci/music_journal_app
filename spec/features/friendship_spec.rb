require "rails_helper"

RSpec.feature "Friendship System", type: :feature do
  let!(:user1) { User.create!(username: "user1", email: "user1@example.com", password: "password123", password_confirmation: "password123") }
  let!(:user2) { User.create!(username: "user2", email: "user2@example.com", password: "password123", password_confirmation: "password123") }


  before do
    login_as(user1, scope: :user)
  end

  scenario "User sends a friend request from the friends page" do
    visit friends_path
    click_link "Add Friend" # Opens friend request form
    fill_in "Enter friend's email:", with: user2.email
    click_button "Send Request"

    expect(page).to have_content "Friend request sent to user2"
  end

  scenario "User fails to send a friend request due to missing email" do
    visit friends_path
    click_link "Add Friend"
    click_button "Send Request" # No email entered

    expect(page).to have_content "User not found"
  end

  scenario "User accepts a friend request" do
    Friendship.create!(user: user1, friend: user2, status: "pending")

    login_as(user2, scope: :user)
    visit friends_path
    click_button "Accept"

    expect(page).to have_content "Friend request accepted!"
  end

  scenario "User declines a friend request" do
    Friendship.create!(user: user1, friend: user2, status: "pending")

    login_as(user2, scope: :user)
    visit friends_path
    click_button "Decline"

    expect(page).to have_content "Friend request declined!"
  end
end
