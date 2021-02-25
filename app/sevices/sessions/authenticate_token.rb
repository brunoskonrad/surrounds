module Sessions
  class AuthenticateToken < ApplicationService

    class EmptyTokenError < StandardError; end
    class AccountNotFoundError < StandardError; end

    attr_reader :token

    def initialize(token)
      @token = token
    end

    def call
      raise AuthenticateToken::EmptyTokenError if token.nil?

      session = Session.find_by(token: token)
      case session
        in nil
          raise AuthenticateToken::AccountNotFoundError if session.nil?
        else
          session.account
      end
    end

  end
end