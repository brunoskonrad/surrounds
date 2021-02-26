require 'rails_helper'

RSpec.describe Sessions::CreateSession do
  let(:test_account) { create(:account, password: "test") }

  context "when input is correct" do
    it "creates a new session if given email and password are correct" do
      expect(test_account.sessions.count).to eq(0)
      described_class.call(test_account.email, "test")
      expect(test_account.sessions.count).to eq(1)
    end

    context "and account has already a session" do
      let!(:old_session) { create(:session, account: test_account) }

      it "removes old sessions in favour of a new one" do
        expect(test_account.sessions.count).to eq(1)
        expect(test_account.sessions.first.token).to eq(old_session.token)

        described_class.call(test_account.email, "test")
        expect(test_account.sessions.count).to eq(1)
        expect(test_account.sessions.first.token).not_to eq(old_session.token)
      end
    end
  end
  
  context "when input is wrong" do
    it "raises WrongInputError" do
      expect { described_class.call("", "") }.to raise_error(::WrongInputError)
      expect { described_class.call(nil, nil) }.to raise_error(::WrongInputError)
    end
  end

  context "when giving email does not match an existing account" do
    it "raises AccountNotFoundError" do
      expect {
        described_class.call("email_with_no_account@email.com", "test")
      }.to raise_error(described_class::AccountNotFoundError)
    end
  end

  context "when given password is invalid" do
    it "raises InvalidPasswordError" do
      expect {
        described_class.call(test_account.email, "wrong_password")
      }.to raise_error(described_class::InvalidPasswordError)
    end
  end
end