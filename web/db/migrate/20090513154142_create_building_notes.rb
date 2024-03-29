class CreateBuildingNotes < ActiveRecord::Migration
  def self.up
    create_table :building_notes do |t|
      t.integer :building_id, :null=>false
      t.integer :user_id, :null=>false
      t.text :notes
      t.timestamps
    end
  end

  def self.down
    drop_table :building_notes
  end
end