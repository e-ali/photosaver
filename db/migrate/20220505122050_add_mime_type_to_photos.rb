class AddMimeTypeToPhotos < ActiveRecord::Migration[7.0]
  def change
    add_column :photos, :mime_type, :string
  end
end
