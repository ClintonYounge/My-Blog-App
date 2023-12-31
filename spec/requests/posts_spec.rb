require 'rails_helper'

RSpec.describe PostsController, type: :request do
  describe 'GET #index' do
    before :each do
      user = User.create(name: 'Cjay', email: 'cjay@example.com', password: 'password',
                         bio: 'On my way to full stack :D', posts_counter: 0)
      sign_in user
      get user_posts_path(user)
    end

    it 'returns a successful response' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      expect(response).to render_template('index')
    end

    it 'includes correct placeholder text in response body' do
      expect(response.body).to include('Cjay')
    end
  end

  describe 'GET #show' do
    before :each do
      user = User.create(name: 'Cjay', email: 'cjay@example.com', password: 'password',
                         bio: 'On my way to full stack :D', posts_counter: 0)
      sign_in user
      post = Post.create(author: user, title: 'My First Post', text: 'This is my post content.')
      get user_post_path(user, post)
    end

    it 'returns a successful response' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in response body' do
      expect(response.body).to include('My First Post')
    end
  end
end
