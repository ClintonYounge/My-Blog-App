require 'rails_helper'

RSpec.describe 'Post index page', type: :feature do
  before do
    @user1 = User.create(name: 'Cjay', bio: 'Cjay bio', photo: 'https://th.bing.com/th/id/R.df818c6db2fe74a4230ccc863663226e?rik=Bt%2fD%2bcd60%2bv0KQ&pid=ImgRaw&r=0')
    @user2 = User.create(name: 'Max', bio: 'Max bio', photo: 'https://th.bing.com/th/id/R.df818c6db2fe74a4230ccc863663226e?rik=Bt%2fD%2bcd60%2bv0KQ&pid=ImgRaw&r=0')
    @user3 = User.create(name: 'Ahmed', bio: 'Ahmed bio', photo: 'https://th.bing.com/th/id/R.df818c6db2fe74a4230ccc863663226e?rik=Bt%2fD%2bcd60%2bv0KQ&pid=ImgRaw&r=0')
    @post1 = Post.create(author: @user1, title: 'User 1 First post', text: 'This is my post content.')
    @post2 = Post.create(author: @user2, title: 'User 2 First post', text: 'This is my post content.')
    @post3 = Post.create(author: @user2, title: 'User 2 Second post', text: 'This is my post content.')
    @post4 = Post.create(author: @user3, title: 'User 3 First Post', text: 'This is my post content.')
    @post5 = Post.create(author: @user3, title: 'User 3 Second Post', text: 'This is my post content.')
    @post6 = Post.create(author: @user3, title: 'User 3 Third Post', text: 'This is my post content.')
  end

  it 'I can see the user profile picture' do
    visit "/users/#{User.first.id}/posts"
    expect(page).to have_css("img[src*='https://th.bing.com/th/id/R.df818c6db2fe74a4230ccc863663226e?rik=Bt%2fD%2bcd60%2bv0KQ&pid=ImgRaw&r=0']")
  end

  it 'I can see the user name' do
    visit "/users/#{User.last.id}/posts"
    expect(page).to have_content('Ahmed')
  end

  it 'I can see the number of posts the user has written' do
    visit "/users/#{User.last.id}/posts"
    expect(page).to have_content('Number of posts: 3')
  end

  it 'I can see a post title' do
    visit "/users/#{User.last.id}/posts"
    expect(page).to have_content('User 3 First Post')
    expect(page).to have_content('User 3 Second Post')
    expect(page).to have_content('User 3 Third Post')
  end

  it 'I can see some of the post body' do
    visit "/users/#{User.first.id}/posts"
    expect(page).to have_content('This is my post content.')
  end

  it 'I can see the first comments on a post' do
    Comment.create(post: @post1, author: @user1, text: 'This is my comment content.')
    Comment.create(post: @post2, author: @user2, text: 'This is my comment content.')
    Comment.create(post: @post3, author: @user2, text: 'This is my comment content.')
    Comment.create(post: @post4, author: @user3, text: 'This is my comment content.')
    Comment.create(post: @post5, author: @user3, text: 'This is my comment content.')
    Comment.create(post: @post6, author: @user3, text: 'This is my comment content.')
    visit "/users/#{User.first.id}/posts"
    expect(page).to have_content('Cjay: This is my comment content.')
  end

  it 'I can see how many comments a post has' do
    Comment.create(post: @post2, author: @user2, text: 'This is my comment content.')
    Comment.create(post: @post2, author: @user2, text: 'This is my comment content.')
    Comment.create(post: @post2, author: @user2, text: 'This is my comment content.')
    Comment.create(post: @post2, author: @user2, text: 'This is my comment content.')
    visit "/users/#{@user2.id}/posts"
    expect(page).to have_content('Comments: 4')
  end

  it 'I can see how many likes a post has' do
    Comment.create(post: @post2, author: @user2, text: 'This is my comment content.')
    Like.create(post: @post2, author: @user2)
    Like.create(post: @post2, author: @user2)
    Like.create(post: @post2, author: @user2)
    Like.create(post: @post2, author: @user2)
    Like.create(post: @post2, author: @user2)
    visit "/users/#{@user2.id}/posts"
    expect(page).to have_content('Likes: 5')
  end

  it 'When I click on a post title I am taken to the post show page' do
    visit "/users/#{@user2.id}/posts"
    click_link 'User 2 First post'
    expect(page).to have_content('User 2 First post')
    expect(page).to have_content('This is my post content.')
  end
end
