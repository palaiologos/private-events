class AddDateToEvents < ActiveRecord::Migration
  def change
    add_column :events, :date, :datetime
    add_column :events, :start_time, :string
    add_index :events, [ :creator_id , :date ], unique: true

  end
end
