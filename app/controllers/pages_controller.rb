class PagesController < ApplicationController
  def home
    @title = "Home"
    @article = Article.all
    #@article.each do |article|
    #  @body = ((RedCloth.new(article.content)).to_html).html_safe
    #  @comment = Comment.new if signed_in?
    #  @title = article.heading
    #end
    @articles = @article.paginate(:page => params[:page])
    @articles_by_month = Article.all(:select => "heading, id, created_at", :order => "created_at DESC").group_by { |article| article.created_at.beginning_of_month }
    @recent_articles = Article.find(:all, :limit => 5)
    #@recent_articles = Article.where(:created_at => (30.days.ago)..(Time.now.utc))
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
