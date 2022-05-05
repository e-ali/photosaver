class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate!

  def current_user
    @current_user ||= authenticate
  end

  private def authenticate!
    authenticate_or_request_with_http_token do |token, _options|
      User.find_by(token: token)
    end
  end
end
