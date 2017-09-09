class AddUserIdToWishes < ActiveRecord::Migration[5.1]
  def change
    add_column :wishes, :user_id, :integer
  end
end
