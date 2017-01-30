require_relative './carrot_preprocessor.rb'

module Carrot
  def create_html(crt_file)
    preprocessor = Preprocessor.new()
    return preprocessor.create_html_file(crt_file)
  end
end