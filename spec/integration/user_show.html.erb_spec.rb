require 'rails_helper'

RSpec.describe 'User Show Page', type: :feature do
  before do
    @user = User.create(name: 'Test User', bio: 'User Bio', photo: 'https://thispersondoesnotexist.com/')
    # Create some posts for the user if needed
  end

  it "displays the user's profile picture, username, bio" do
    visit user_path(@user) # Visit the user's show page
    expect(page).to have_css("img[src*='https://thispersondoesnotexist.com/']", wait: 10)
    expect(page).to have_content(@user.name)
    expect(page).to have_content(@user.bio)
  end

  it 'displays the number of posts the user has written' do
    # Create some posts for the user
    @user.posts.create(title: 'Post 1', text: 'Text 1')
    @user.posts.create(title: 'Post 2', text: 'Text 2')
    visit root_path(@user)
    expect(page).to have_content('Posts: 2')
  end

  it 'displays the first 3 posts of the user' do
    # Create some posts for the user
    @user.posts.create(title: 'Post 1', text: 'Text 1')
    @user.posts.create(title: 'Post 2', text: 'Text 2')
    @user.posts.create(title: 'Post 3', text: 'Text 3')

    visit user_path(@user)
    expect(page).to have_content('Post 1')
    expect(page).to have_content('Post 2')
    expect(page).to have_content('Post 3')
  end

  it "redirects to the post's show page when a post is clicked" do
    # Create a post for the user
    post = @user.posts.create(title: 'Test Post', text: 'Post Text')

    visit user_path(@user)
    click_link_or_button 'Test Post', wait: 10
    expect(current_path).to eq(user_post_path(@user, post)) # Use user_post_path instead of post_path
  end
  it "redirects to the user's post index page when 'View All Posts' is clicked" do
    # Ensure that there is a link or button with the text "View All Posts" on the page
    visit user_path(@user)
    expect(page).to have_link('See All Posts', href: user_posts_path(@user))

    click_link_or_button 'See All Posts', wait: 10
    expect(current_path).to eq(user_posts_path(@user))
  end
end