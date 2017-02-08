class SettingsController < ApplicationController
  before_action :require_login
  include Carrot

  def edit
  end

  def queue_page_gen
    text = params[:body]
    if text != ""
      # TODO kick off page generation
      text = create_html(text)
      if text == ""
        raise Exception.new("Empty file body")
      end

      # Okay, its good, now do something with it
    else
      flash[:error] = "Invalid input"
    end
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
