class AddPriceToReservation < ActiveRecord::Migration
  def self.up
  	add_column :reservations, :has_paid, :boolean, null: false, default: false
  	add_column :reservations, :price, :integer, null: false, default: 0
  end
  def self.down
  	remove_column :reservations, :has_paid, :boolean
  	remove_column :reservations, :price, :integer
  end
end
