class ChangeColumn < ActiveRecord::Migration
  def self.up
    rename_column :articles, :content, :content_string
    add_column :articles, :content, :text
    
    Article.reset_column_information
    Article.find_each { |c| c.update_attribute(:content, c.content_string) } 
    remove_column :articles, :content_string
  end

  def self.down
  end
end
