class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :fullname
      t.string :email
      t.string :password_digest
      t.timestamps
    end

    add_index :users, :fullname
    add_index :users, :email
  end
end
