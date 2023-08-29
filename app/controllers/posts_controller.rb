class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @user = User.find(params[:user_id])
    puts "User: #{@user.inspect}"
    @post = @user.posts.find(params[:id])
    puts "Post: #{@post.inspect}"
  end  
end