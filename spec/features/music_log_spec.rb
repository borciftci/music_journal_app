require "rails_helper"

RSpec.feature "Music Log Management", type: :feature do
  let!(:user) { User.create!(username: "testuser", email: "test@example.com", password: "password123", password_confirmation: "password123") }

  before do
    login_as(user, scope: :user)
  end

  scenario "User successfully creates a new music log" do
    visit new_music_log_path

    fill_in "music_log[song_name]", with: "Bohemian Rhapsody"
    fill_in "music_log[artist]", with: "Queen"
    select "Rock", from: "music_log[genre]"
    fill_in "music_log[mood]", with: "Happy"
    fill_in "music_log[notes]", with: "One of the greatest songs of all time"
    fill_in "music_log[date]", with: Date.today.strftime("%Y-%m-%d")
    click_button "Save"


    expect(page).to have_content "Music Log was successfully created."
    expect(page).to have_content "Bohemian Rhapsody"
  end

  scenario "User fails to create a music log due to missing required fields" do
    visit new_music_log_path

    click_button "Save" # Try submitting an empty form

    expect(page).to have_content "Please fill in all required fields."
  end

  scenario "User updates a music log" do
    visit new_music_log_path

    fill_in "music_log[song_name]", with: "Bohemian Rhapsody"
    fill_in "music_log[artist]", with: "Queen"
    select "Rock", from: "music_log[genre]"
    fill_in "music_log[mood]", with: "Happy"
    fill_in "music_log[notes]", with: "One of the greatest songs of all time"
    fill_in "music_log[date]", with: Date.today.strftime("%Y-%m-%d")
    click_button "Save"

    expect(page).to have_content "Music Log was successfully created."
    expect(page).to have_content "Bohemian Rhapsody"

    visit music_logs_path

    within(".music-log", text: "Bohemian Rhapsody") do
      find(".edit-button").click
    end

    fill_in "music_log[song_name]", with: "Bohemian Rhapsody2"
    fill_in "music_log[artist]", with: "Queen2"
    select "Rock", from: "music_log[genre]"
    fill_in "music_log[mood]", with: "Happy2"
    fill_in "music_log[notes]", with: "One of the greatest songs of all time2"
    fill_in "music_log[date]", with: Date.today.strftime("%Y-%m-%d")
    click_button "Save"
    expect(page).to have_content "Music Log was successfully updated."
    expect(page).to have_content "Bohemian Rhapsody2"
  end

  scenario "User deletes a music log" do
    visit new_music_log_path

    fill_in "music_log[song_name]", with: "Bohemian Rhapsody"
    fill_in "music_log[artist]", with: "Queen"
    select "Rock", from: "music_log[genre]"
    fill_in "music_log[mood]", with: "Happy"
    fill_in "music_log[notes]", with: "One of the greatest songs of all time"
    fill_in "music_log[date]", with: Date.today.strftime("%Y-%m-%d")
    click_button "Save"

    expect(page).to have_content "Music Log was successfully created."
    expect(page).to have_content "Bohemian Rhapsody"

    visit music_logs_path

    within(".music-log", text: "Bohemian Rhapsody") do
      find(".delete-button").click
    end

    accept_alert

    expect(page).to have_content "Music Log was successfully destroyed."

  end
end
