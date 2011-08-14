class Article < ActiveRecord::Base
  attr_accessible :content, :heading, :image, :tag_ids, :tags, :tag_name, :tag_attributes, :article_tags

  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :article_tags
  has_many :tags, :through => :article_tags
  accepts_nested_attributes_for :tags, :reject_if => proc { |attributes| attributes['tag_name'].blank? }
  
  #validates :heading, :presence => true
  validates :content, :presence => true
  validates :user_id, :presence => true
  
  has_attached_file :image,
                    :styles => {
       :thumb  => "100x100>",
       :small  => "450x450>" }
    
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