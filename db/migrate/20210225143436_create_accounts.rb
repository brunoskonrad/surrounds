class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :display_name

      t.timestamps
    end
    add_index :accounts, :email, unique: true
  end
end
