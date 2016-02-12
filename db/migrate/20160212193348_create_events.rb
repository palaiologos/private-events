class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :location
      t.datetime :date
      t.text :description

      t.timestamps null: false
    end
    add_column :events, :creator_id, :integer
    add_index :events, :creator_id
    add_index :events, [:date, :creator_id], unique: true
  end
end
