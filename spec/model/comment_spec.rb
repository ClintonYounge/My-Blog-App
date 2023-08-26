require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'is valid with valid attributes' do
    user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    post = Post.create(author: user, title: 'Hello', text: 'This is my first post')
    comment = Comment.new(author: user, post:, text: 'Content')
    expect(comment).to be_valid
  end

  it 'is invalid without a user' do
    post = Post.create(title: 'Title', text: 'This is my first post')
    comment = Comment.new(post:, text: 'Content')
    expect(comment).to_not be_valid
  end

  it 'is invalid without a post' do
    user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    comment = Comment.new(author: user, text: 'Content')
    expect(comment).to_not be_valid
  end

  it 'is invalid without text' do
    user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    post = Post.create(author: user, title: 'Title', text: 'This is my first post')
    comment = Comment.new(author: user, post:)
    expect(comment).to_not be_valid
  end

  it 'increments the post\'s comments_counter when a comment is created' do
    user = User.create(name: 'John', posts_counter: 0)
    post = Post.create(title: 'Title', comments_counter: 0, likes_counter: 0, author: user)
    Comment.create(author: user, post:, text: 'Content')

    expect(post.comments_counter).to eq(1)
  end
end
