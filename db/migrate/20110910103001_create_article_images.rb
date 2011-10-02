class CreateArticleImages < ActiveRecord::Migration
  def self.up
    create_table :article_images do |t|
            t.integer :id
            t.integer :article_id
            t.integer :image_id
      t.timestamps
    end
  end

  def self.down
    drop_table :image_tags
  end
end