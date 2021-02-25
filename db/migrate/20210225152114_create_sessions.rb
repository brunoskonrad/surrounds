class CreateSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :sessions do |t|
      t.string :token, null: false
      t.datetime :last_time_used
      t.references :account

      t.timestamps
    end
    add_index :sessions, :token, unique: true
  end
end
