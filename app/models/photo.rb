class Photo < ApplicationRecord
  validate :url_format

  scope :unprocessed, -> { where(processed_at: nil) }

  def self.import_photos(urls)
    Photo.transaction do
      urls.each do |url|
        photo = Photo.new(url:)

        if photo.valid?
          photo.save!
        else
          return false
        end

      end
    end
  end

  private def url_format
    if url.blank? || !url.match(URI::DEFAULT_PARSER.make_regexp(%w[http https]))
      errors.add(:url, "Invalid URL: '#{url}'")
    end
  end
end
