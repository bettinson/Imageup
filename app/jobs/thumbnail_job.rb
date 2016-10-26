class Thumbnail
  @queue = :serve_thumbnail

  def self.perform(image)
    @image = Image.find(image["id"])
    file = image["path"]
    if Rails.env.production?
      path = "/home/matt/images/#{file}"
    else
      path = "#{Rails.root}/public/images/#{file}"
    end
    thumbnail = MiniMagick::Image.open(path)
    thumbnail.resize "200x200"

    thumb_path = "#{Rails.root}/public/images/thumbnail-#{file}"
    if Rails.env.production?
      thumb_path = "/home/matt/images/thumbnail-#{file}"
      thumbnail.write(thumb_path)
    else
      thumb_path = "#{Rails.root}/public/images/thumbnail-#{file}"
      thumbnail.write(thumb_path)
    end

    @image.update_attribute(:thumb_nail_path, thumb_path)
    #Resize image
  end
end
