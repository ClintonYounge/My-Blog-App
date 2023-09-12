require 'rails_helper'

RSpec.describe 'Post show page', type: :feature do
  before do
    @user1 = User.create(name: 'Cjay', bio: 'Cjay bio', photo: 'https://th.bing.com/th/id/R.df818c6db2fe74a4230ccc863663226e?rik=Bt%2fD%2bcd60%2bv0KQ&pid=ImgRaw&r=0')
    @user2 = User.create(name: 'Max', bio: 'Max bio', photo: 'https://th.bing.com/th/id/R.df818c6db2fe74a4230ccc863663226e?rik=Bt%2fD%2bcd60%2bv0KQ&pid=ImgRaw&r=0')
    @user3 = User.create(name: 'Ahmed', bio: 'Ahmed bio', photo: 'https://th.bing.com/th/id/R.df818c6db2fe74a4230ccc863663226e?rik=Bt%2fD%2bcd60%2bv0KQ&pid=ImgRaw&r=0')
    @post1 = Post.create(author: @user1, title: 'User 1 First Post', text: 'This is user 1 first post content.')
    @post2 = Post.create(author: @user2, title: 'User 2 First Post', text: 'This is user 2 first post content.')
    @post3 = Post.create(author: @user2, title: 'User 2 Second Post', text: 'This is user 2 second post content.')
    @post4 = Post.create(author: @user3, title: 'User 3 First Post', text: 'This is user 3 first post content.')
    @post5 = Post.create(author: @user3, title: 'User 3 Second Post', text: 'This is user 3 second post content.')
    @post6 = Post.create(author: @user3, title: 'User 3 Third Post', text: 'This is user 3 third post content.')
  end

  it 'shows the post title' do
    visit user_post_path(@user1, @post1)
    expect(page).to have_content(@post1.title)
  end

  it 'I can see who wrote the post' do
    visit user_post_path(@user1, @post1)
    expect(page).to have_content(@post1.author.name)
  end

  it 'I can see how many comments the post has' do
    visit user_post_path(@user1, @post1)
    expect(page).to have_content(@post1.comments.count)
  end

  it 'I can see how many likes the post has' do
    visit user_post_path(@user1, @post1)
    expect(page).to have_content(@post1.likes.count)
  end

  it 'I can see the post content' do
    visit user_post_path(@user1, @post1)
    expect(page).to have_content(@post1.text)
  end

  it 'I can see the username of each commentor' do
    Comment.create(author: @user1, post: @post1, text: 'This is a comment')
    Comment.create(author: @user2, post: @post1, text: 'This is another comment')
    visit user_post_path(@user1, @post1)
    expect(page).to have_content(@user1.name)
    expect(page).to have_content(@user2.name)
  end

  it 'I can see the content of each comment' do
    Comment.create(author: @user1, post: @post1, text: 'This is the first comment')
    Comment.create(author: @user2, post: @post1, text: 'This is the second comment')
    visit user_post_path(@user1, @post1)
    expect(page).to have_content('This is the first comment')
    expect(page).to have_content('This is the second comment')
  end
end
