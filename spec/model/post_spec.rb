require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'comments_counter should return zero for a new post' do
    post = Post.new(author: nil, title: 'Hello', text: 'This is my first post')
    expect(post.comments_counter).to eq(0)
  end

  it 'is valid with valid attributes' do
    user = User.create(name: 'Tom', email: 'tom@example.com', password: 'password')
    post = Post.new(author: user, title: 'Hello', text: 'This is my first post')
    expect(post).to be_valid
  end

  it 'is not valid without a title' do
    user = User.create(name: 'Tom', email: 'tom@example.com', password: 'password')
    post = Post.new(author: user, text: 'This is my first post')
    expect(post).to_not be_valid
  end

  it 'recent_comments should return 5 recent comments' do
    user = User.create(name: 'Tom', email: 'tom@example.com', password: 'password')
    post = Post.create(author: user, title: 'Hello', text: 'This is my first post')

    5.times do
      Comment.create(author: user, post: post, text: 'This is a comment')
    end

    expect(post.recent_comments.length).to eq(5)
  end

  it 'should return fewer than 3 comments' do
    user = User.create(name: 'Tom', email: 'tom@example.com', password: 'password')
    post = Post.create(author: user, title: 'Hello', text: 'This is my first post')

    2.times do
      Comment.create(author: user, post: post, text: 'This is a comment')
    end

    expect(post.recent_comments.length).to eq(2)
  end
end
