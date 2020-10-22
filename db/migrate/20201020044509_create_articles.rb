class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string	:title, null: false, default: ""
      t.text	:content
      t.string 	:author, null: false, defaulu: ""
      t.string	:thumbnail, null: false, default: ""
      t.timestamps null: false
    end
    add_column 	:reservations, :url_hash, :string
  end
  def self.down
  	drop_table :articles
  	remove_column :reservations, :url_hash, :string
  end
end
