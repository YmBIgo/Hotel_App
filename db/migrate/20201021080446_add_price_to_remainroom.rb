class AddPriceToRemainroom < ActiveRecord::Migration
  def self.up
  	add_column 	  :remainrooms, :room_prices, :string, null: false, default: ""
  end
  def self.down
  	remove_column :remainrooms, :room_prices, :string, null: false, default: ""
  end
end
