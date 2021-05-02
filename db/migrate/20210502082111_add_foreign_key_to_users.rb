class AddForeignKeyToUsers < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :users, :users, column: :create_user_id
  end
end
