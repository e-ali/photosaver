require 'open-uri'

class PhotosProcessingJob < ApplicationJob
  queue_as :default

  def perform
    Dir.mkdir("tmp/saved_photos") unless File.exists?("tmp/saved_photos")

    Photo.unprocessed.find_each do |photo|
      process_photo(photo)
    end
  end

  private def process_photo(photo)
    begin
      data = URI.open(photo.url)
    rescue OpenURI::HTTPError
      Rails.logger.error("Error opening Photo ID #{photo.id}.")
      return false
    end

    filename = data.base_uri.to_s.split("/").last
    IO.copy_stream(data, File.join("tmp/saved_photos/", filename))

    photo.update!(
      processed_at: Time.now,
      mime_type: data.meta.dig("content-type")
    )
  end
end
