class CreateArticleTagJoinTable < ActiveRecord::Migration
  def self.up
    create_table :articles_tags, :id => false do |t|
      t.references :article, :tag
    end
  end

  def self.down
    drop_table :articles_tags
  end
end