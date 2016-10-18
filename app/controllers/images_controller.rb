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
    respond_to do |format|
      if @image.save
        format.html { redirect_to images_index_url, notice: "Image was uploaded!" }
      else
        format.html { render :upload }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end
end
