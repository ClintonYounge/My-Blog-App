require 'rails_helper'

RSpec.describe 'User show page', type: :feature do
  before do
    @user1 = User.create(name: 'Cjay', bio: 'Cjay bio', photo: 'https://th.bing.com/th/id/R.df818c6db2fe74a4230ccc863663226e?rik=Bt%2fD%2bcd60%2bv0KQ&pid=ImgRaw&r=0')
    @user2 = User.create(name: 'Max', bio: 'Max bio', photo: 'https://th.bing.com/th/id/R.df818c6db2fe74a4230ccc863663226e?rik=Bt%2fD%2bcd60%2bv0KQ&pid=ImgRaw&r=0')
    @user3 = User.create(name: 'Ahmed', bio: 'Ahmed bio', photo: 'https://th.bing.com/th/id/R.df818c6db2fe74a4230ccc863663226e?rik=Bt%2fD%2bcd60%2bv0KQ&pid=ImgRaw&r=0')
  end

  it 'I can see the user profile picture' do
    visit "/users/#{User.first.id}"
    expect(page).to have_css("img[src*='https://th.bing.com/th/id/R.df818c6db2fe74a4230ccc863663226e?rik=Bt%2fD%2bcd60%2bv0KQ&pid=ImgRaw&r=0']")
  end

  it 'I can see the user name' do
    visit "/users/#{User.first.id}"
    expect(page).to have_content('Cjay')
  end

  it 'I can see the number of posts the user has written' do
    Post.create(author: @user1, title: 'My First Post', text: 'This is my post content.')
    Post.create(author: @user2, title: 'My First Post', text: 'This is my post content.')
    Post.create(author: @user2, title: 'My First Post', text: 'This is my post content.')
    Post.create(author: @user3, title: 'My First Post', text: 'This is my post content.')
    Post.create(author: @user3, title: 'My First Post', text: 'This is my post content.')
    Post.create(author: @user3, title: 'My First Post', text: 'This is my post content.')
    visit "/users/#{User.first.id}"
    expect(page).to have_content('Number of posts: 1')
  end

  it 'I can see the user bio' do
    visit "/users/#{User.first.id}"
    expect(page).to have_content('Cjay bio')
  end

  it 'I can see the user last 3 posts' do
    Post.create(author: @user1, title: 'My First Post', text: 'This is my post content.')
    Post.create(author: @user1, title: 'My Second Post', text: 'This is my post content.')
    Post.create(author: @user1, title: 'My Third Post', text: 'This is my post content.')
    Post.create(author: @user1, title: 'My Fourth Post', text: 'This is my post content.')
    Post.create(author: @user1, title: 'My Fifth Post', text: 'This is my post content.')
    visit "/users/#{User.first.id}"
    expect(page).not_to have_content('My First Post')
    expect(page).not_to have_content('My Second Post')
    expect(page).to have_content('My Third Post')
    expect(page).to have_content('My Fourth Post')
    expect(page).to have_content('My Fifth Post')
  end
  it 'I can see a button that lets me view all of the user posts' do
    visit "/users/#{User.first.id}"
    expect(page).to have_link('See all posts')
  end
  it 'When I click a user post, it redirects me to that post show page' do
    Post.create(author: @user1, title: 'My First Post', text: 'This is my post content.')
    visit "/users/#{User.first.id}"
    click_link 'My First Post'
    expect(page).to have_current_path("/users/#{User.first.id}/posts/#{Post.first.id}")
  end
  it 'When I click the See all posts button, it redirects me to the user posts index page' do
    Post.create(author: @user1, title: 'My First Post', text: 'This is my post content.')
    visit "/users/#{User.first.id}"
    click_link 'See all posts'
    expect(page).to have_current_path("/users/#{User.first.id}/posts")
  end
end
