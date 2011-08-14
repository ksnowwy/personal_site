class CreateArticleTags < ActiveRecord::Migration
  def self.up
    create_table :article_tags do |t|
            t.integer :id
            t.integer :article_id
            t.integer :tag_id
      t.timestamps
    drop_table :articles_tags
    end
  end

  def self.down
    drop_table :article_tags
  end
end
