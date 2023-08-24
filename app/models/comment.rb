class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post

  after_commit :increment_comments_count, on: :create

  private

  def increment_comments_count
    post.increment!(:comments_counter)
  end
end
