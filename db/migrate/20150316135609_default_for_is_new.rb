class DefaultForIsNew < ActiveRecord::Migration
  def change

    change_column_default :posts, :isNew, false
  end
end
