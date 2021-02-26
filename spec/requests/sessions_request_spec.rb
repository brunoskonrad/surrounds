require 'rails_helper'

RSpec.describe "Sessions", type: :request do

  pending "POST /" do
    it "returns http success" do
      post "/session/"
      expect(response).to have_http_status(:success)
    end
  end

  pending "DELETE /" do
    it "returns http success" do
      delete "/session/"
      expect(response).to have_http_status(:success)
    end
  end

end
