require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'GET #index' do
    before :each do
      user = User.create(name: 'Cjay', bio: 'On my way to full stack :D', posts_counter: 0)
      get users_path(user)
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
      user = User.create(name: 'Cjay', bio: 'On my way to full stack :D', posts_counter: 0)
      get user_path(user)
    end

    it 'returns a successful response' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in response body' do
      expect(response.body).to include('On my way to full stack :D')
    end
  end
end
