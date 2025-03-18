require "rails_helper"

RSpec.feature "Music Log Management", type: :feature do
  let!(:user) { User.create!(username: "testuser", email: "test@example.com", password: "password123", password_confirmation: "password123") }

  before do
    login_as(user, scope: :user)
  end

  scenario "User successfully creates a new music log" do
    visit new_music_log_path

    fill_in "Song Name", with: "Bohemian Rhapsody"
    fill_in "Artist", with: "Queen"
    select "Rock", from: "Genre"
    fill_in "Mood", with: "Happy"
    fill_in "Notes", with: "One of the greatest songs of all time"
    fill_in "Date", with: Date.today.strftime("%Y-%m-%d") # Ensure valid format
    click_button "Save"

    expect(page).to have_content "Music Log was successfully created."
    expect(page).to have_content "Bohemian Rhapsody"
  end

  scenario "User fails to create a music log due to missing required fields" do
    visit new_music_log_path

    click_button "Save" # Try submitting an empty form

    expect(page).to have_content "Song Name can't be blank"
    expect(page).to have_content "Artist can't be blank"
    expect(page).to have_content "Genre can't be blank"
    expect(page).to have_content "Mood can't be blank"
    expect(page).to have_content "Date can't be blank"
  end
end
