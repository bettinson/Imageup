require_relative './carrot_preprocessor.rb'

module Carrot
  def create_html(crt_contents, user)
    Preprocessor.create_html_file(crt_contents, user)
  end

  private
  def hash_file_name(filename)
    require 'digest/sha1'
    return Digest::SHA1.hexdigest(filename)
  end
end
