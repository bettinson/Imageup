class SettingsController < ApplicationController
  include Carrot
  # TODO
  # Create POST request containing blob of text to queue a Carrot background 
  # Resque job.
  
  def edit
    # byebug
    @text ||= create_html(nil)
  end
end
