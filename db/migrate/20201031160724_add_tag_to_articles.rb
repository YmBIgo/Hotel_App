class AddTagToArticles < ActiveRecord::Migration
  def self.up
  	add_column :articles, :tag_ids, :string, null: false, default: ""
  	add_column :plans, :tag_ids, :string, null: false, default: ""
  end
  def self.down
  	remove_column :articles, :tag_ids, :string
  	remove_column :plans, :tag_ids, :string
  end
end
