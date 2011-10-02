class Article < ActiveRecord::Base
  attr_accessible :content, :heading, :image, :tag_ids, :tags, :tag_name, :tag_attributes, :article_tags, :image_ids, :image_file_name, :image_attributes, :article_images, :images

  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :article_tags
  has_many :tags, :through => :article_tags
  accepts_nested_attributes_for :tags, :reject_if => proc { |attributes| attributes['tag_name'].blank? }
  has_many :article_images
  has_many :images, :through => :article_images
  accepts_nested_attributes_for :images, :reject_if => proc { |attributes| attributes['image_name'].blank? }, :allow_destroy => true
  
  #validates :heading, :presence => true
  validates :content, :presence => true
  validates :user_id, :presence => true
    
  default_scope :order => 'articles.created_at DESC'
  
  #def comments(params)
   # @article = Article.find(params[:id])
   # @article.comments.create!(params[:comment])
   # @comment.user_id = current_user.id
   # if @comment.save
   #   flash[:success] = "Comment created!"
   #   redirect_to '/contact'
   # else
   #   render '/about'
   # end
  #end
  
end