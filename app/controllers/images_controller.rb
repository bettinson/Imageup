class ImagesController < ApplicationController
  def display
    @image = Image.find(params[:id])
  end

  def index
    @images = Image.all
  end

  def upload
    @image = Image.new
  end

  def create
    @image = Image.new
    @image.title = params[:image][:title]
    # @image.user = params[:user]
    puts @image.title
    respond_to do |format|
      if @image.save
        format.html { redirect_to images_index_url, notice: "Image was uploaded!" }
      else
        format.html { render :index }
      end
    end
  end
end
