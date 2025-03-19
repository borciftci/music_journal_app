require "rails_helper"

RSpec.feature "Music Log Filtering", type: :feature do
  let!(:user) { User.create!(username: "testuser", email: "test@example.com", password: "password123", password_confirmation: "password123") }

  let!(:today_log) { MusicLog.create!(user: user, song_name: "Shape of You", artist: "Ed Sheeran", genre: "Pop", mood: "Happy", notes: "Great song!", date: Date.today) }
  let!(:last_week_log) { MusicLog.create!(user: user, song_name: "Bohemian Rhapsody", artist: "Queen", genre: "Rock", mood: "Excited", notes: "Classic!", date: 7.days.ago) }
  let!(:last_month_log) { MusicLog.create!(user: user, song_name: "Blinding Lights", artist: "The Weeknd", genre: "Pop", mood: "Excited", notes: "Nice!", date: 1.month.ago) }

  before do
    login_as(user, scope: :user)
    visit music_logs_path
  end

  scenario "User filters logs by today" do
    click_link "Today"
    expect(page).to have_content "Shape of You"
    expect(page).not_to have_content "Bohemian Rhapsody"
    expect(page).not_to have_content "Blinding Lights"
  end

  scenario "User filters logs by last week" do
    click_link "Last Week"
    expect(page).to have_content "Bohemian Rhapsody"
    expect(page).to have_content "Shape of You"
    expect(page).not_to have_content "Blinding Lights"
  end

  scenario "User filters logs by last month" do
    click_link "Last Month"
    expect(page).to have_content "Blinding Lights"
    expect(page).to have_content "Shape of You"
    expect(page).to have_content "Bohemian Rhapsody"
  end
end
