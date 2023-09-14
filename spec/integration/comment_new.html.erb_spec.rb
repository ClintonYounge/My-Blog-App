require 'rails_helper'

RSpec.describe 'Comment new', type: :feature do
  before do
    @user1 = User.create(name: 'Cjay', bio: 'Cjay bio', email: 'cjay@example.com', password: 'password',
                         posts_counter: 0, photo: 'https://th.bing.com/th/id/R.df818c6db2fe74a4230ccc863663226e?rik=Bt%2fD%2bcd60%2bv0KQ&pid=ImgRaw&r=0')
    @user2 = User.create(name: 'Max', bio: 'Max bio', email: 'max@example.com', password: 'password', posts_counter: 0,
                         photo: 'https://th.bing.com/th/id/R.df818c6db2fe74a4230ccc863663226e?rik=Bt%2fD%2bcd60%2bv0KQ&pid=ImgRaw&r=0')
    @user3 = User.create(name: 'Ahmed', bio: 'Ahmed bio', email: 'ahmed@example.com', password: 'password',
                         posts_counter: 0, photo: 'https://th.bing.com/th/id/R.df818c6db2fe74a4230ccc863663226e?rik=Bt%2fD%2bcd60%2bv0KQ&pid=ImgRaw&r=0')
    @post1 = Post.create(author: @user1, title: 'My First Post', text: 'This is my post content.')
    @post2 = Post.create(author: @user2, title: 'My Second Post', text: 'This is my second post content.')
    @post3 = Post.create(author: @user3, title: 'My Third Post', text: 'This is my third post content.')
    @current_user = User.create(name: 'Test User', email: 'test@example.com', password: 'password')
    login_as(@current_user, scope: :user)
  end

  it 'Can see the new comment page' do
    visit user_posts_path(@user1)
    click_link 'My First Post'
    click_link 'Add Comment'
    expect(page).to have_current_path(new_user_post_comment_path(@user1, @post1))
    expect(page).to have_content('Comment')
    expect(page).to have_button('Add Comment')
  end

  it 'Can create a comment' do
    visit new_user_post_comment_path(@user1, @post1)
    fill_in 'Comment', with: 'This is my comment.'
    click_button 'Add Comment'
    expect(page).to have_content('This is my comment.')
  end
end
