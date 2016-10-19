# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'
serve_static_assets = true

run Rails.application
