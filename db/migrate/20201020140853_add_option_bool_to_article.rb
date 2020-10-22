class AddOptionBoolToArticle < ActiveRecord::Migration
  def self.up
  	add_column 	  :articles, :article_type, :integer, null: false, default: 0
  end
  def self.down
  	remove_column :articles, :article_type, :integer, null: false, default: 0
  end
end
