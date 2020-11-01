class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string	   :name, null: false, default: ""
      t.string	   :plan_ids, null: false, default: ""
      t.string	   :article_ids, null: false, default: ""
      t.timestamps null: false
    end
  end
end
