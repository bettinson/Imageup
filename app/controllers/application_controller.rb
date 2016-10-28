class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  task 'resque:setup' => :environment
  include SessionsHelper
end
