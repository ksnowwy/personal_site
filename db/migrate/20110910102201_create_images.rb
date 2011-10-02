class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.integer :image_width
      t.integer :image_height
      t.integer :article_id

      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
