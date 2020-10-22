class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer		:plan_id, null: false, default: 0
      t.integer		:user_id, null: false, default: 0
      t.integer   :people_num, null: false, default: 0
      t.integer		:payment_type, null: false, default: 0
      t.string		:email, null: false, default: ""
      t.string		:first_name, null: false, default: ""
      t.string		:last_name,  null: false, default: ""
      t.date		  :start_date
      t.date 		  :end_date
      
      t.timestamps null: false
    end
  end
end
