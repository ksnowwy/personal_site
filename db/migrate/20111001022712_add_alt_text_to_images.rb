class AddAltTextToImages < ActiveRecord::Migration
  def self.up
    add_column :images, :image_alt_text, :string
  end

  def self.down
    remove_column :images, :image_alt_text
  end
end
