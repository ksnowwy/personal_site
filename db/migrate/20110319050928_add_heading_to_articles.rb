class AddHeadingToArticles < ActiveRecord::Migration
  def self.up
    add_column :articles, :heading, :string
    Article.reset_column_information
  end

  def self.down
    remove_column :articles, :heading
  end
end
