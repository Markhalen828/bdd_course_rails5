require 'rails_helper'

RSpec.feature "Adding comments to articles" do
  before do
    @Steve = User.create(email: "steve@example.com", password: "password")
    @Fred = User.create(email: "fred@example.com", password: "password")
    @article = Article.create(title: "The first article", body: "Lorem ipsum dolar sit are, constru.", user: @Steve)
  end
  
  scenario "permits a signed in user to comment on article" do
    login_as(@Fred)
    
    visit "/"
    
    click_link @article.title
    
    fill_in "New Comment", with: "An amazing article"
    click_button "Add Comment"
    
    expect(page).to have_content("Comment has been created.")
    expect(page).to have_content("An amazing article")
    
    expect(current_path).to eq(article_path(@article.id)) 
  end
end