class CreateMoments < ActiveRecord::Migration[6.1]
  def change
    create_table :moments do |t|
      t.text :message, null: false
      t.point :position, null: false, srid: 4326

      t.timestamps

      t.index :position, type: :spatial
    end
  end
end
