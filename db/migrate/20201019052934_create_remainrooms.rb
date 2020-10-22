class CreateRemainrooms < ActiveRecord::Migration
  def change
    create_table :remainrooms do |t|
      t.string  	:reservation_ids, null: false, default: ""
      t.date		:room_date
      t.string		:room_ids, null: false, default: ""
      t.timestamps 	null: false
    end
  end
end
