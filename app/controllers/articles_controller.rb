class ArticlesController < ApplicationController
  before_filter :authenticate, :only => [:index, :new, :create, :edit, :update, :destroy]
  before_filter :admin_user, :only => [:index, :new, :create, :edit, :update, :destroy]
  
  def index
    @articles = Article.paginate(:page => params[:page])
  end
  
  def show
    @article = Article.find(params[:id])
    @body = ((RedCloth.new(@article.content)).to_html).html_safe
    @comment = Comment.new if signed_in?
    @title = @article.heading
    @articles_by_month = Article.all(:select => "heading, id, created_at", :order => "created_at DESC").group_by { |article| article.created_at.beginning_of_month }
    @recent_articles = Article.find(:all, :limit => 5)
    @tags = Tag.find(:all)
  end
  
  def new
    @article = Article.new
    @tags = Tag.find(:all)
    article_tag = @article.article_tags.build()
    @article_tags = @article.tags.all
    @article.tags.build
    3.times do
        tag = @article.tags.build()
    end
    @tag = @article.article_tags.build(params[:tag])
  end
  
  def create
    if @article = current_user.articles.create!(params[:article])
      redirect_to root_path, :flash => { :success => "Article created!" }
    else
      redirect_to "/articles/new"
    end
  end
  
  def edit
    @article = Article.find(params[:id])
    @title = "article"
    @tags = Tag.find(:all)
    @article_tags = @article.tags.all
  end
  
  def update
    @article = Article.find(params[:id])
    params[:article][:tag_ids] ||= []
    if @article.update_attributes(params[:article])
      redirect_to @article, :flash => { :success => "Article updated." }
    else
      @title = "Edit article"
      render 'edit'
    end
  end
  
  def destroy
  end
  
  def commenter
    @article = Article.find(params[:id])
    @article.comments.create!(:content => content)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to '/contact'
    else
      render '/about'
    end
  end
  
    private
    
    def admin_user
      #@user = User.find(params[:id])
      redirect_to(root_path) if !current_user.admin? 
    end
end