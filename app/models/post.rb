class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  after_create :increment_posts_count

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def increment_posts_count
    author.increment!(:posts_counter)
  end
end
