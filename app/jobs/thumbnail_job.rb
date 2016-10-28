class Thumbnail
  @queue = :serve_thumbnail

  # Param is an image hash
  def self.perform(image)
    @image = Image.find(image["id"])

    #File is original
    file = image["path"]
    if Rails.env.production?
      path = "/home/matt/images/#{file}"
    else
      path = "#{Rails.root}/public/images/#{file}"
    end
    thumbnail = MiniMagick::Image.open(path)
    thumbnail.resize "300x300"

    thumb_path = "#{Rails.root}/public/images/thumbnail-#{file}"
    if Rails.env.production?
      thumb_path = "/home/matt/images/thumbnail-#{file}"
      thumbnail.write(thumb_path)
    else
      thumb_path = "#{Rails.root}/public/images/thumbnail-#{file}"
      thumbnail.write(thumb_path)
    end

    @image.update_attribute(:thumb_nail_path, "thumbnail-#{file}")
    #Resize image
  end
end
