class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @session = Sessions::CreateSession.call(params[:email], params[:password])
  end

  def destroy
    Sessions::DestroySession.call(authorization_token)
  end
end
