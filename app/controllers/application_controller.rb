class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate!

  def photos
    if Photo.import_photos(photos_params[:photo_urls])
      render json: "Photos created.", status: :ok
    else
      render json: "Invalid URLs.", status: :unprocessable_entity
    end
  end

  def current_user
    @current_user ||= authenticate
  end

  private def authenticate!
    authenticate_or_request_with_http_token do |token, _options|
      User.find_by(token: token)
    end
  end

  private def photos_params
    params.permit(photo_urls: [])
  end
end
