class TagsController < ApplicationController
  before_filter :authenticate, :only => [:index, :new, :create, :edit, :update, :destroy]
  before_filter :admin_user, :only => [:index, :new, :create, :edit, :update, :destroy]
  
  def index
    @tags = Tag.all
  end
  
  def show
    @tag = Tag.find(params[:id])
    @articles = @tag.articles
    @articles_by_month = @tag.articles(:select => "heading, id, created_at", :order => "created_at DESC").group_by { |article| article.created_at.beginning_of_month }
  end
  
  def new
    @tag = Tag.new
  end
  
  def create
    @tag = Tag.new(params[:tag])
    if @tag.save
      redirect_to "/articles/new", :flash => { :success => "Tag created!" }
    else
      redirect_to root_path
    end
  end
  
  def edit
    @article = Article.find(params[:id])
    @title = "Edit article"
  end
  
    private
    
    def admin_user
      #@user = User.find(params[:id])
      redirect_to(root_path) if !current_user.admin? 
    end
end