require "rails_helper"

RSpec.feature "User Authentication", type: :feature do
  scenario "User successfully signs up with required details" do
    visit new_user_registration_path

    fill_in "Username", with: "testuser"
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password123"
    fill_in "Password confirmation", with: "password123"

    save_and_open_page

    click_button "Sign Up"

    expect(page).to have_content "Welcome, testuser"
  end

  scenario "User fails to sign up due to missing username" do
    visit new_user_registration_path

    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password123"
    fill_in "Password confirmation", with: "password123"
    click_button "Sign Up"

    expect(page).to have_content "Username can't be blank"
  end

  scenario "User enters mismatched passwords" do
    visit new_user_registration_path

    fill_in "Username", with: "testuser"
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password123"
    fill_in "Password confirmation", with: "password321" # Mismatch
    click_button "Sign Up"

    expect(page).to have_content "Password confirmation doesn't match Password"
  end

  scenario "User successfully logs in" do
    user = User.create!(username: "testuser", email: "test@example.com", password: "password123", password_confirmation: "password123")

    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    expect(page).to have_content "Welcome, testuser"
  end
end
