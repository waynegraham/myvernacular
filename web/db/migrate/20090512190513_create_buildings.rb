class CreateBuildings < ActiveRecord::Migration
  
  def self.up
    create_table :buildings do |t|
      t.integer :user_id, :null=>false
    	t.string :name, :null=>false
    	t.string :country, :null=>false
    	t.string :state
    	t.string :city
    	t.decimal :lat, :precision => 15, :scale => 10
      t.decimal :lon, :precision => 15, :scale => 10
      t.timestamps
    end
  end
  
  def self.down
    drop_table :buildings
  end
  
end