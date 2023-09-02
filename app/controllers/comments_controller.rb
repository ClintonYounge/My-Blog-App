class CommentsController < ApplicationController
  before_action :set_post

  def create
    @comment = @post.comments.build(comment_params)
    @comment.author = current_user

    if @comment.save
      redirect_to user_post_path(@user, @post), notice: 'Comment was successfully created.'
    else
      redirect_to user_post_path(@user, @post), alert: 'Comment creation failed.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def set_post
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
  end
end
