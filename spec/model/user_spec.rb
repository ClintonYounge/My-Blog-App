require 'rails_helper'

RSpec.describe User, type: :model do
  it 'post counter should return zero for new user' do
    user = User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    expect(user.posts_counter).to eq(0)
  end

  it 'is valid with valid attributes' do
    user = User.new(
      name: 'Tom',
      email: 'tom@example.com',
      password: 'password',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Teacher from Mexico.',
      posts_counter: 0
    )
    expect(user).to be_valid
  end

  it 'is not valid without a name' do
    user = User.new(
      email: 'tom@example.com',
      password: 'password',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Teacher from Mexico.',
      posts_counter: 0
    )
    expect(user).to_not be_valid
  end

  it 'recent_posts should return 3 posts' do
    user = User.create(
      name: 'Tom',
      email: 'tom@example.com',
      password: 'password',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Teacher from Mexico.'
    )
    5.times do
      Post.create(author: user, title: 'Hello World', text: 'This is my post')
    end
    expect(user.recent_posts.length).to eq(3)
  end

  it 'should return fewer than 3 posts' do
    user = User.create(
      name: 'Tom',
      email: 'tom@example.com',
      password: 'password',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Teacher from Mexico.'
    )
    2.times do
      Post.create(author: user, title: 'Hello World', text: 'This is my post')
    end
    expect(user.recent_posts.length).to eq(2)
  end
end
