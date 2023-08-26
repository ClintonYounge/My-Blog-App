class Like < ApplicationRecord
  validates :author, presence: true
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post

  after_commit :increment_likes_count, on: :create

  private

  def increment_likes_count
    post.increment!(:likes_counter)
  end
end
