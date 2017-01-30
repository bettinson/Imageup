require 'resque'
require './app/jobs/thumbnail_job.rb'

class ImagesController < ApplicationController
  before_action :require_login, only: [:upload, :create, :destroy]
  include ImagesHelper

  def display
    @image = Image.find(params[:id])
  end

  def index
    @images = Image.all
    respond_to do |format|
      format.json { render json: @images }
      format.html { render :index }
    end
  end

  def upload
    @image = Image.new
    path = write_image(params[:image][:picture])
    @image.path = path unless path == nil
    @image.title = params[:image][:title]
    @image.user = current_user

    current_user.images << @image

    respond_to do |format|
      if @image.save
        Resque.enqueue(CreateThumbnail, @image)
        format.html { redirect_to root_path, notice: "Image was uploaded!" }
        # format.json { render json: status: :uploaded }
      else
        format.html { render :create }
        format.json { render json: @image.errors, status: :unprocessable_entity }
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

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in"
      redirect_to login_path
    end
  end
end
