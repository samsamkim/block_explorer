require "rails_helper"

RSpec.describe FetchNearTransactions do
  describe ".call" do
    let(:mock_response) do
      instance_double(Net::HTTPSuccess, body: [
        {
          "hash" => "tx_001",
          "sender" => "sender_1",
          "receiver" => "receiver_1",
          "actions" => [
            { "type" => "Transfer", "data" => { "deposit" => "1000" } }
          ]
        }
      ].to_json)
    end

    before do
      allow(Net::HTTP).to receive(:get_response).and_return(mock_response)
      allow(mock_response).to receive(:is_a?).with(Net::HTTPSuccess).and_return(true)
    end

    it "saves a new transaction" do
      expect {
        described_class.call
      }.to change(Transaction, :count).by(1)

      tx = Transaction.last
      expect(tx.tx_hash).to eq("tx_001")
    end

    it "ignores transactions that are not transfers" do
      non_transfer_body = [
        {
          "hash" => "tx_002",
          "sender" => "sender_x",
          "receiver" => "receiver_y",
          "actions" => [ { "type" => "FunctionCall", "data" => {} } ]
        }
      ].to_json

      mock_response = instance_double(Net::HTTPSuccess, body: non_transfer_body)
      allow(Net::HTTP).to receive(:get_response).and_return(mock_response)
      allow(mock_response).to receive(:is_a?).with(Net::HTTPSuccess).and_return(true)

      expect { described_class.call }.not_to change(Transaction, :count)
    end
  end
end
