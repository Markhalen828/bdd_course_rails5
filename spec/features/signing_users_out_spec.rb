require "rails_helper"

RSpec.feature "Signing out signed in user" do
  before do
    @steve = User.create(email: "steve@example.com", password: "password")
    
    visit "/"
    click_link "Sign in"
    fill_in "Email", with: @steve.email
    fill_in "Password", with: @steve.password
    click_button "Log in"
  end
  
  scenario do
    visit "/"
    click_link "Sign out"
    expect(page).to have_content("Signed out successfully")
    expect(page).not_to have_content("Sign out")
  end
  
end