require "rails_helper"

RSpec.describe "Articles", type: :request do
  
  before do
    @Steve = User.create(email: "steve@example.com", password: "password")
    @Fred = User.create(email: "Fred@example.com", password: "password")
    @article = Article.create!(title: "Title One", body: "Body of article one", user: @Steve)
  end
  
  describe "Get /articles/:id/edit" do
    context 'with non-signed in user' do
      before { get "/articles/#{@article.id}/edit" }
    
      it "redirect to signed in page" do
        expect(response.status).to eq 302
        flash_message = "You need to sign in or sign up before continuing."
        expect(flash[:alert]).to eq flash_message
      end
    end 
    
    context 'with signed in user who is non-owner' do
      before do
        login_as(@Fred)
        get "/articles/#{@article.id}/edit"
      end
      
      it "redirect to homepage" do
        expect(response.status).to eq 302
        flash_message = "You can only edit articles you own"
        expect(flash[:alert]).to eq flash_message
      end
    end
    
    context 'with signed in user who is owner, successful edit' do
      before do
        login_as(@Steve)
        get "/articles/#{@article.id}/edit"
      end
      
      it "successfully edits article" do
        expect(response.status).to eq 200
      end
    end
  end
  
  describe 'GET /articles/:id' do
    context 'with exisiting article' do
      before { get "/articles/#{@article.id}" }
      
      it "handles exisiting article" do
        expect(response.status).to eq 200
      end
    end
    
    context "with non-exisiting article" do
      before { get "/articles/xxxx" }
      
      it "handles non-exisiting article" do
        expect(response.status).to eq 302
        flash_message = "The article you are looking for could not be found"
        expect(flash[:alert]).to eq flash_message
      end
    end
  end
end