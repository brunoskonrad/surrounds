module Sessions
  class AuthenticateToken < ApplicationService

    class EmptyTokenError < UnauthorizedError; end
    class AccountNotFoundError < UnauthorizedError; end

    attr_reader :token

    def initialize(token)
      @token = token
    end

    def call
      raise AuthenticateToken::EmptyTokenError.new(
        "Token is required to perform operation."
      ) if token.nil? || token.empty?

      session = Session.find_by(token: token)
      case session
        in nil
          raise AuthenticateToken::AccountNotFoundError.new(
            "Provided token is not valid."
          ) if session.nil?
        else
          session.account
      end
    end

  end
end