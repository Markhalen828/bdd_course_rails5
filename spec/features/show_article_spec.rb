require "rails_helper"

RSpec.feature "Showing an article" do
  
  before do
    @steve = User.create(email: "steve@example.com", password: "password")
    @Fred = User.create(email: "fred@example.com", password: "password")
    @article = Article.create(title: "The first article", body: "Lorem ipsum dolar sit are, constru.", user: @steve)
  end
  
  scenario "to non-signed in user hide the Edit and Delete buttons" do
    visit "/"
    click_link @article.title
    
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end
  
  scenario "to non-owner in user hide the Edit and Delete buttons" do
    login_as(@Fred)
    
    visit "/"
    click_link @article.title
    
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end
  
end