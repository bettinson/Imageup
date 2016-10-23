class ImagesController < ApplicationController
  def display
    @image = Image.find(params[:id])
  end

  def index
    @images = Image.all
  end

  def upload
    @image = Image.new
    uploaded_io = params[:image][:picture]
    if uploaded_io
      hashed_name = hash_file_name(uploaded_io.original_filename + Image.count.to_s)
      extension = File.extname(uploaded_io.original_filename)


      production = "/home/matt/photos/#{hashed_name + extension}"
      local = "/Users/mattbettinson/photos/#{hashed_name + extension}"
      File.open(production, 'wb') do |file|
        file.write(uploaded_io.read)
        @image.path = hashed_name + extension
      end
    end

    @image.title = params[:image][:title]
    # @image.user = params[:user]
    respond_to do |format|
      if @image.save
        format.html { redirect_to images_index_url, notice: "Image was uploaded!" }
      else
        format.html { render :create }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @image = Image.new
  end

  private
  def hash_file_name(filename)
    require 'digest/sha1'
    return Digest::SHA1.hexdigest(filename)
  end
end
