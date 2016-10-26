module ApplicationHelper
  def get_full_path(file)
    if Rails.env.production?
      path = "/home/matt/images/#{file}"
    else
      path = "#{Rails.root}/public/images/#{file}"
    end
    return path
  end
end
