class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :url
      t.string :tags
      t.boolean :suit
      t.integer :vote

      t.timestamps null: false
    end
  end
end
