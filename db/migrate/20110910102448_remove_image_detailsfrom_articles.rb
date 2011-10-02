class RemoveImageDetailsfromArticles < ActiveRecord::Migration
  def self.up
    remove_column(:articles, :image_file_name)
    remove_column(:articles, :image_content_type)
    remove_column(:articles, :image_file_size)
  end

  def self.down
    add_column(:articles, :image_file_name)
    add_column(:articles, :image_content_type)
    add_column(:articles, :image_file_size)
  end
end
