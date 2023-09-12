require 'rails_helper'

RSpec.describe 'Post new', type: :feature do
  before do
    @user1 = User.create(name: 'Cjay', bio: 'Cjay bio', photo: 'https://th.bing.com/th/id/R.df818c6db2fe74a4230ccc863663226e?rik=Bt%2fD%2bcd60%2bv0KQ&pid=ImgRaw&r=0')
    @user2 = User.create(name: 'Max', bio: 'Max bio', photo: 'https://th.bing.com/th/id/R.df818c6db2fe74a4230ccc863663226e?rik=Bt%2fD%2bcd60%2bv0KQ&pid=ImgRaw&r=0')
    @user3 = User.create(name: 'Ahmed', bio: 'Ahmed bio', photo: 'https://th.bing.com/th/id/R.df818c6db2fe74a4230ccc863663226e?rik=Bt%2fD%2bcd60%2bv0KQ&pid=ImgRaw&r=0')
  end

  it 'Has a new post page' do
    visit '/users'
    click_link 'Cjay'
    expect(page).to have_current_path("/users/#{User.first.id}")
    click_link 'See all posts'
    expect(page).to have_current_path("/users/#{User.first.id}/posts")
    click_button 'Create Post'
    expect(page).to have_current_path("/users/#{User.first.id}/posts/new")
    expect(page).to have_content('Title')
    expect(page).to have_content('Text')
    expect(page).to have_button('Create Post')
  end

  it 'Create a post' do
    visit "/users/#{User.first.id}/posts/new"
    fill_in 'Title', with: 'My First Post'
    fill_in 'Text', with: 'This is my post content.'
    click_button 'Create Post'
    expect(page).to have_content('My First Post')
    expect(page).to have_content('This is my post content.')
  end
end
