module Sessions
  class DestroySession < ApplicationService

    def initialize(token)
      @token = token
    end

    def call
      session = Session.find_by(token: @token)

      return false if session.nil?
      return true if session.delete
    end

  end
end