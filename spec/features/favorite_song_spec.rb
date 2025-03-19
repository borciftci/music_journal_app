require "rails_helper"

RSpec.feature "Favorite Song Management", type: :feature do
  let!(:user) { User.create!(username: "testuser", email: "test@example.com", password: "password123", password_confirmation: "password123") }
  let!(:music_log) { MusicLog.create!(user: user, song_name: "Blinding Lights", artist: "The Weeknd", genre: "Pop", mood: "Excited", notes: "Great beat", date: Date.today) }

  before do
    login_as(user, scope: :user)
    visit music_logs_path
  end

  scenario "User marks a song as their favorite" do
    within(".music-log", text: "Blinding Lights") do
      find(".favorite-button").click
    end



    expect(page).to have_content "Favorite song updated"
  end

  scenario "User removes a favorite song" do
    user.update(favorite_song_id: music_log.id)
    visit music_logs_path

    within(".music-log", text: "Blinding Lights") do
      find(".favorite-button").click
    end



    expect(page).to have_content "Favorite song removed"
  end
end
