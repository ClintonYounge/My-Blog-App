require 'rails_helper'

RSpec.describe 'User show page', type: :feature do
  before do
    @user1 = User.create(name: 'Cjay', bio: 'Cjay bio', email: 'cjay@example.com', password: 'password',
                         posts_counter: 0, photo: 'https://th.bing.com/th/id/R.df818c6db2fe74a4230ccc863663226e?rik=Bt%2fD%2bcd60%2bv0KQ&pid=ImgRaw&r=0')
    @user2 = User.create(name: 'Max', bio: 'Max bio', email: 'max@example.com', password: 'password', posts_counter: 0,
                         photo: 'https://th.bing.com/th/id/R.df818c6db2fe74a4230ccc863663226e?rik=Bt%2fD%2bcd60%2bv0KQ&pid=ImgRaw&r=0')
    @user3 = User.create(name: 'Ahmed', bio: 'Ahmed bio', email: 'ahmed@example.com', password: 'password',
                         posts_counter: 0, photo: 'https://th.bing.com/th/id/R.df818c6db2fe74a4230ccc863663226e?rik=Bt%2fD%2bcd60%2bv0KQ&pid=ImgRaw&r=0')
    @current_user = User.create(name: 'Test User', email: 'test@example.com', password: 'password')
    login_as(@current_user, scope: :user)
  end

  it 'I can see the user profile picture' do
    visit user_path(@user1)
    expect(page).to have_css("img[src*='https://th.bing.com/th/id/R.df818c6db2fe74a4230ccc863663226e?rik=Bt%2fD%2bcd60%2bv0KQ&pid=ImgRaw&r=0']")
  end

  it 'I can see the user name' do
    visit user_path(@user1)
    expect(page).to have_content('Cjay')
  end

  it 'I can see the number of posts the user has written' do
    Post.create(author: @user1, title: 'My First Post', text: 'This is my post content.')
    Post.create(author: @user2, title: 'My First Post', text: 'This is my post content.')
    Post.create(author: @user2, title: 'My First Post', text: 'This is my post content.')
    Post.create(author: @user3, title: 'My First Post', text: 'This is my post content.')
    Post.create(author: @user3, title: 'My First Post', text: 'This is my post content.')
    Post.create(author: @user3, title: 'My First Post', text: 'This is my post content.')
    visit user_path(@user1)
    expect(page).to have_content('Number of posts: 1')
  end

  it 'I can see the user bio' do
    visit user_path(@user1)
    expect(page).to have_content('Cjay bio')
  end

  it 'I can see the user last 3 posts' do
    first_post = Post.create(author: @user1, title: 'My First Post', text: 'This is my first post content.')
    second_post = Post.create(author: @user1, title: 'My Second Post', text: 'This is my second post content.')
    third_post = Post.create(author: @user1, title: 'My Third Post', text: 'This is my third post content.')
    fourth_post = Post.create(author: @user1, title: 'My Fourth Post', text: 'This is my fourth post content.')
    fifth_post = Post.create(author: @user1, title: 'My Fifth Post', text: 'This is my fifth post content.')
    visit user_path(@user1)
    expect(page).not_to have_content(first_post.text)
    expect(page).not_to have_content(second_post.text)
    expect(page).to have_content(third_post.text)
    expect(page).to have_content(fourth_post.text)
    expect(page).to have_content(fifth_post.text)
  end

  it 'I can see a button that lets me view all of the user posts' do
    visit user_path(@user1)
    expect(page).to have_link('See all posts')
  end

  it 'When I click a user post, it redirects me to that post show page' do
    Post.create(author: @user1, title: 'My First Post', text: 'This is my post content.')
    visit user_path(@user1)
    click_link 'My First Post'
    expect(page).to have_current_path(user_post_path(@user1, Post.first))
  end

  it 'When I click the See all posts button, it redirects me to the user posts index page' do
    Post.create(author: @user1, title: 'My First Post', text: 'This is my post content.')
    visit user_path(@user1)
    click_link 'See all posts'
    expect(page).to have_current_path(user_posts_path(@user1))
  end
end
