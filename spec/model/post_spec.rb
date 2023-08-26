require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'will be invalid if title is blank' do
    post = Post.new(text: 'This is my post')
    expect(post).to_not be_valid
  end

  it 'title must not exceed 250 characters' do
    post = Post.new(title: 'a' * 251, text: 'This is my post')
    expect(post).to_not be_valid
  end

  it 'comments_counter must be 0 by zero by default' do
    user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    post = Post.create(author: user, title: 'Hello', text: 'This is my first post')
    expect(post.comments_counter).to eq(0)
  end

  it 'comments_counter should be 1' do
    user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    post = Post.create(author: user, title: 'Hello', text: 'This is my first post')
    Comment.create(author: user, post:, text: 'This is my first comment')
    expect(post.comments_counter).to eq(1)
  end

  it 'likes_counter must be 0 by zero by default' do
    user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    post = Post.create(author: user, title: 'Hello', text: 'This is my first post')
    expect(post.likes_counter).to eq(0)
  end

  it 'likes_counter should be 1' do
    user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    post = Post.create(author: user, title: 'Hello', text: 'This is my first post')
    Like.create(author: user, post:)
    expect(post.likes_counter).to eq(1)
  end

  describe '#increment_post_counter' do
    it 'should increment comments_counter by 1' do
      user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
      post = Post.create(author: user, title: 'Hello', text: 'This is my first post')
      expect { Comment.create(author: user, post:, text: 'This is my first comment') }.to change {
                                                                                            post.comments_counter
                                                                                          }.by(1)
    end
  end

  describe '#recent_comments' do
    it 'should return 5 recent comments' do
      user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
      post = Post.create(author: user, title: 'Hello', text: 'This is my first post')
      10.times { |i| Comment.create(author: user, post:, text: "This is my #{i} comment") }
      expect(post.recent_comments.count).to eq(5)
    end

    it 'should return 3 comments' do
      user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
      post = Post.create(author: user, title: 'Hello', text: 'This is my first post')
      3.times { |i| Comment.create(author: user, post:, text: "This is my #{i} comment") }
      expect(post.recent_comments.count).to eq(3)
    end
  end
end
