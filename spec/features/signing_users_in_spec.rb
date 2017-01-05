require "rails_helper"
RSpec.feature "Users signin" do 
  before do
    @steve = User.create!(email: "steve@example.com", password: "password") 
  end
  scenario "with valid credentials" do
  visit "/"
  
  click_link "Sign in"
  fill_in "Email", with: @steve.email 
  fill_in "Password", with: @steve.password 
  click_button "Log in"
  
  expect(page).to have_content("Signed in successfully.") 
  expect(page).to have_content("Signed in as #{@steve.email}") 
  expect(page).not_to have_link("Sign in") 
  expect(page).not_to have_link("Sign up")
  end 
end

