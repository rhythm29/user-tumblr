class UsernameNotNullPosts < ActiveRecord::Migration[5.1]
change_column :posts, :username, :string, null: false
end
