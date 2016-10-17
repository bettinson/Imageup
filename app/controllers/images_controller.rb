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
    @image = Image.create params[:image]
    respond_to do |format|
      if @image.save
        format.html { redirect_to image_show_url, notice: "Thanks" }
      else
        format.html { render :index }
      end
    end
  end
end
