require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:each) do
    @user = User.create(
      name: 'Tom',
      email: 'tom@example.com',
      password: 'password'
    )
  end

  it 'is valid with valid attributes' do
    post = Post.create(author: @user, title: 'Hello', text: 'This is my first post')
    comment = Comment.new(author: @user, post: post, text: 'Content')
    expect(comment).to be_valid
  end

  it 'is invalid without a user' do
    post = Post.create(title: 'Title', text: 'This is my first post')
    comment = Comment.new(post: post, text: 'Content')
    expect(comment).to_not be_valid
  end

  it 'is invalid without a post' do
    comment = Comment.new(author: @user, text: 'Content')
    expect(comment).to_not be_valid
  end

  it 'is invalid without text' do
    post = Post.create(author: @user, title: 'Title', text: 'This is my first post')
    comment = Comment.new(author: @user, post: post)
    expect(comment).to_not be_valid
  end

  it 'increments the post\'s comments_counter when a comment is created' do
    post = Post.create(title: 'Title', comments_counter: 0, likes_counter: 0, author: @user)
    comment = Comment.create(author: @user, post: post, text: 'Content')
    post.reload

    expect(post.comments_counter).to eq(1)
  end
end
