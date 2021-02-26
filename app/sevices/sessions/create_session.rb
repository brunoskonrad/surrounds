module Sessions
  class CreateSession < ApplicationService

    class WrongInputError < WrongInputError; end
    class AccountNotFoundError < WrongInputError; end
    class InvalidPasswordError < WrongInputError; end

    def initialize(email, password)
      @email = email
      @password = password
    end

    def call
      raise CreateSession::WrongInputError.new(
        "Email or password are missing"
      ) if @email.nil? || @email.empty? || @password.nil? || @password.empty?

      account = Account.find_by(email: @email)

      raise CreateSession::AccountNotFoundError.new(
        "Email or password are wrong"
      ) if account.nil?

      if account.authenticate(@password)
        ActiveRecord::Base.transaction do
          # Remove existing sessions just for security reasons, ya know?
          account.sessions.each do |session|
            Sessions::DestroySession.call(session.token)
          end

          Session.create(token: SecureRandom.uuid, account: account)
        end
      else
        raise CreateSession::InvalidPasswordError.new("Email or password are wrong")
      end
    end

  end
end