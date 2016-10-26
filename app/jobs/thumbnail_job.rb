class Thumbnail
  @queue = :serve_thumbnail

  def self.perform(image)
    byebug
    file = image["path"]
    if Rails.env.production?
      path = "/home/matt/images/#{file}"
    else
      path = "#{Rails.root}/public/images/#{file}"
    end
    new_image = MiniMagick::Image.open(path)
    return new_image
    #Resize image
  end
end
