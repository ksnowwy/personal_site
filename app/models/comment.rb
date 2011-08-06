class Comment < ActiveRecord::Base
  attr_accessible :content
  
  belongs_to :user
  belongs_to :article
  
  validates :content, :presence => true
  validates :user_id, :presence => true
  validates :article_id, :presence => true
  
  default_scope :order => 'comments.created_at DESC'
end
