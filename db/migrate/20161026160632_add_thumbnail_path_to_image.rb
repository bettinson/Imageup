class AddThumbnailPathToImage < ActiveRecord::Migration[5.0]
  def change
    add_column :images, :thumb_nail_path, :string
  end
end
