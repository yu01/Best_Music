class AddNewColumn < ActiveRecord::Migration
  def change
      add_column :posts, :isNew, :boolean

  end

end
