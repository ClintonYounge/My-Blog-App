class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: { to_table: :users }
      t.references :post, null: false, foreign_key: { to_table: :posts }
      t.timestamps
    end

    add_index :likes, :author_id
    add_index :likes, :post_id
  end
end
