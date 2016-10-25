class ImagesController < ApplicationController
  def display
    @image = Image.find(params[:id])
  end

  def index
    @images = Image.all
  end

  def upload
    if logged_in?
      @image = Image.new
      uploaded_io = params[:image][:picture]
      if uploaded_io
        hashed_name = hash_file_name(uploaded_io.original_filename + Image.count.to_s)
        extension = File.extname(uploaded_io.original_filename)

        if Rails.env.production?
          path = "/home/matt/images/#{hashed_name + extension}"
        else
          path = "#{Rails.root}/public/images/#{hashed_name + extension}"
        end
        File.open(path, 'wb') do |file|
          file.write(uploaded_io.read)
          @image.path = hashed_name + extension
        end
      end

      @image.title = params[:image][:title]
      # @image.user = params[:user]
      @image.user = current_user
      current_user.images << @image
      respond_to do |format|
        if @image.save
          format.html { redirect_to images_index_url, notice: "Image was uploaded!" }
        else
          format.html { render :create }
          format.json { render json: @image.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to sessions_new_url, notice: "You need to log in to post images." }
      end
    end
  end

  def create
    @image = Image.new
  end

  def destroy
    @image = Image.find(params[:id])
    user = User.find(@image.user_id)
    if logged_in? && current_user.email == user.email
      respond_to do |format|
        if @image.destroy
          format.html { redirect_to images_index_url, notice: "Image was deleted!" }
        else
          format.html { redirect_to images_index_url, notice: "Image was unable to be deleted." }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to images_index_url, notice: "You need to log in to delete your own images." }
      end
    end
  end

  private
  def hash_file_name(filename)
    require 'digest/sha1'
    return Digest::SHA1.hexdigest(filename)
  end
end
