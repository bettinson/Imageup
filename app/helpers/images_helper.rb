module ImagesHelper
  # Writes image to the file system
  def write_image(uploaded_io)
    if uploaded_io
      hashed_name = hash_file_name(uploaded_io.original_filename + Image.count.to_s)
      extension = File.extname(uploaded_io.original_filename)
      if Rails.env.production?
        path = "/home/matt/images/#{hashed_name + extension}"
      else
        path = "#{Rails.root}/public/images/#{hashed_name + extension}"
      end
      File.open(path, 'wb') do |file|
        file.write(uploaded_io.read)
      end
      return (hashed_name + extension)
    end
    return nil;
  end
end
