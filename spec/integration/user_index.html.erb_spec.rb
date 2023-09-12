require 'rails_helper'

RSpec.describe 'User index page', type: :feature do
  before do
    @user1 = User.create(name: 'Cjay', bio: 'Cjay bio', photo: 'https://th.bing.com/th/id/R.df818c6db2fe74a4230ccc863663226e?rik=Bt%2fD%2bcd60%2bv0KQ&pid=ImgRaw&r=0')
    @user2 = User.create(name: 'Max', bio: 'Max bio', photo: 'https://th.bing.com/th/id/R.df818c6db2fe74a4230ccc863663226e?rik=Bt%2fD%2bcd60%2bv0KQ&pid=ImgRaw&r=0')
    @user3 = User.create(name: 'Ahmed', bio: 'Ahmed bio', photo: 'https://th.bing.com/th/id/R.df818c6db2fe74a4230ccc863663226e?rik=Bt%2fD%2bcd60%2bv0KQ&pid=ImgRaw&r=0')
  end

  it 'displays the username of all users' do
    visit '/users'
    expect(page).to have_content('Cjay')
    expect(page).to have_content('Max')
    expect(page).to have_content('Ahmed')
  end

  it 'shows the profile picture of all users' do
    visit '/users'
    expect(page).to have_css("img[src*='https://th.bing.com/th/id/R.df818c6db2fe74a4230ccc863663226e?rik=Bt%2fD%2bcd60%2bv0KQ&pid=ImgRaw&r=0']")
  end

  it 'displays the number of posts each user has written' do
    Post.create(author: @user1, title: 'My First Post', text: 'This is my post content.')
    Post.create(author: @user2, title: 'My First Post', text: 'This is my post content.')
    Post.create(author: @user2, title: 'My First Post', text: 'This is my post content.')
    Post.create(author: @user3, title: 'My First Post', text: 'This is my post content.')
    Post.create(author: @user3, title: 'My First Post', text: 'This is my post content.')
    Post.create(author: @user3, title: 'My First Post', text: 'This is my post content.')
    visit '/users'
    expect(page).to have_content('Number of posts: 1')
    expect(page).to have_content('Number of posts: 2')
    expect(page).to have_content('Number of posts: 3')
  end

  it 'when clicked, the username links to the user show page' do
    visit '/users'
    click_link 'Cjay'
    expect(page).to have_current_path("/users/#{User.first.id}")
  end
end