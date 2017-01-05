require "rails_helper"

RSpec.feature "Signup users" do
  scenario "with valid credentials" do
    visit "/"
    click_link "Sign up"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "Password"
    fill_in "Password confirmation", with: "Password"
    click_button "Sign up"
    
    expect(page).to have_content("You have signed up successfully")
  end
  
  scenario "with invalid credentials" do
    visit "/"
    click_link "Sign up"
    fill_in "Email", with: ""
    fill_in "Password", with: ""
    fill_in "Password confirmation", with: ""
    click_button "Sign up"
    
    #expect(page).to have_content("You have not signed up successfully")
  end
end