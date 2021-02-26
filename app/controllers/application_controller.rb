class ApplicationController < ActionController::Base
  rescue_from WrongInputError, :with => :handle_wrong_input
  rescue_from UnauthorizedError, :with => :handle_unauthorized

  def current_account
    @current_account ||= Sessions::AuthenticateToken.call(authorization_token)
  end

  def authorization_token
    # NOTE: this code seems meh, but it works :shrug:
    authorization = request.headers['Authorization']

    return nil if authorization.nil?
    authorization.gsub("Token ", "")
  end

  private

  def handle_wrong_input(error)
    @message = error.message

    render 'shared/error', status: :bad_request
  end

  def handle_unauthorized(error)
    @message = error.message

    render 'shared/error', status: :unauthorized
  end
end
