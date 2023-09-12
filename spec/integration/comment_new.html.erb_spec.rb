require 'rails_helper'

RSpec.describe 'Comment new', type: :feature do
  before do
    @user1 = User.create(name: 'Cjay', bio: 'Cjay bio', photo: 'https://th.bing.com/th/id/R.df818c6db2fe74a4230ccc863663226e?rik=Bt%2fD%2bcd60%2bv0KQ&pid=ImgRaw&r=0')
    @user2 = User.create(name: 'Max', bio: 'Max bio', photo: 'https://th.bing.com/th/id/R.df818c6db2fe74a4230ccc863663226e?rik=Bt%2fD%2bcd60%2bv0KQ&pid=ImgRaw&r=0')
    @user3 = User.create(name: 'Ahmed', bio: 'Ahmed bio', photo: 'https://th.bing.com/th/id/R.df818c6db2fe74a4230ccc863663226e?rik=Bt%2fD%2bcd60%2bv0KQ&pid=ImgRaw&r=0')
    @post1 = Post.create(author: @user1, title: 'My First Post', text: 'This is my post content.')
    @post2 = Post.create(author: @user2, title: 'My Second Post', text: 'This is my second post content.')
    @post3 = Post.create(author: @user3, title: 'My Third Post', text: 'This is my third post content.')
  end

  it 'Can see the new comment page' do
    visit '/users'
    click_link 'Cjay'
    expect(page).to have_current_path("/users/#{User.first.id}")
    click_link 'See all posts'
    expect(page).to have_current_path("/users/#{User.first.id}/posts")
    click_link 'My First Post'
    expect(page).to have_current_path("/users/#{User.first.id}/posts/#{Post.first.id}")
    click_link 'Add Comment'
    expect(page).to have_current_path("/users/#{User.first.id}/posts/#{Post.first.id}/comments/new")
    expect(page).to have_content('Comment')
    expect(page).to have_button('Add Comment')
  end

  it 'Can create a comment' do
    visit "/users/#{User.first.id}/posts/#{Post.first.id}/comments/new"
    fill_in 'Comment', with: 'This is my comment.'
    click_button 'Add Comment'
    expect(page).to have_content('This is my comment.')
  end
end
