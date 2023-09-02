class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = Like.new(author: current_user, post: @post)
    @like.save
  end
end
