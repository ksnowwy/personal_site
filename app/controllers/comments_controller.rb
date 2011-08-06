class CommentsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]

  def index
    @article = Article.find(params[:article_id])
    @comment = @article.comments.all
    @comments = Comment.paginate(:page => params[:page])
  end

  def new
    @comment = Comment.new
  end
  
  def create
    @article = Article.find(params[:article_id])
    @comment = current_user.comments.build(params[:comment])
    @comment.article_id = @article.id
    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to @article
    else
      render @article
    end
  end

  def destroy
  end
end