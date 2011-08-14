class PagesController < ApplicationController
  def home
    @title = "Home"
    @articles = Article.paginate(:page => params[:page], :per_page => 5)
    @articles_by_month = Article.all(:select => "heading, id, created_at", :order => "created_at DESC").group_by { |article| article.created_at.beginning_of_month }
    @recent_articles = Article.find(:all, :limit => 5)
    @tags = Tag.all
  end

  def about
    @title = "About"
  end
  
  def projects
    @title = "Projects"
  end
  
  def admin
    @title = "Admin"
  end

end
