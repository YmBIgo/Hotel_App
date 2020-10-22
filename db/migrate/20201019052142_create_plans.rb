class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string 	   	:title, null: false, default: ""
      t.integer	   	:price, null: false, default: 0
      t.integer		:people_num, null: false, default: 1
      t.integer		:room_num, null: false, default: 1
      t.text		:explanation
      t.text		:html_content
      t.string		:photo_url, null: false, default: ""
      t.date		:start_date
      t.date 		:end_date

      t.timestamps null: false
    end
  end
end
