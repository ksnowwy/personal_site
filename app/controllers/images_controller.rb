class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def show
    @image = Image.find(params[:id])
    @articles = @image.articles
  end
  
  def index
    @images = Image.all(:order => "created_at DESC")
  end
  
  def create
    @image = Image.new(params[:image])
    if @image.save
      redirect_to "/images", :flash => { :success => "Image created!" }
    else
      redirect_to "/images/new"
    end
  end

end
