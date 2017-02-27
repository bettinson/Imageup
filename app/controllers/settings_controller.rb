class SettingsController < ApplicationController
  before_action :require_login
  include Carrot

  def edit
  end

  def queue_page_gen
    text = params[:body]
    current_user.pre_carrot = text
    if text != ""
      text = create_html(text, current_user)
      current_user.carrot = text
    else
      raise Exception.new("Empty file body")
      flash[:error] = "Invalid input"
    end
    current_user.save
  end

  # This is duplicated code. Obviously not ideal
  private
  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in"
      redirect_to login_path
    end
  end
end
