class ChangeVoteDefaultInPosts < ActiveRecord::Migration

  change_column_default :posts, :vote, 1

  change_column_default :posts, :suit, false
end
