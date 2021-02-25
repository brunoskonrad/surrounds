class ApplicationController < ActionController::Base
  rescue_from Sessions::AuthenticateToken::EmptyTokenError,
    :with => handle_wrong_input

  def handle_wrong_input(error)
    puts error.inspect
  end
end
