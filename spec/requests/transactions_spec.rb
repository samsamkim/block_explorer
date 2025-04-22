require 'rails_helper'

RSpec.describe "Transactions", type: :request do
  describe "GET /" do
    it "renders the index page" do
      get root_path
      expect(response).to have_http_status(:ok)
    end
  end
end
