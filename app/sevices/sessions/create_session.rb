module Sessions
  class CreateSession < ApplicationService

    class WrongInputError < StandardError; end
    class AccountNotFoundError < StandardError; end
    class InvalidPasswordError < StandardError; end

    def initialize(email, password)
      @email = email
      @password = password
    end

    def call
      raise CreateSession::WrongInputError if @email.nil? || @password.nil?

      account = Account.find_by(email: @email)

      raise CreateSession::AccountNotFoundError if account.nil?

      if account.authenticate(@password)
        Session.create(token: SecureRandom.uuid, account: account)
      else
        raise CreateSession::InvalidPasswordError
      end
    end

  end
end