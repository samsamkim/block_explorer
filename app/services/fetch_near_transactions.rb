require "net/http"
require "uri"
require "json"

class FetchNearTransactions
  API_URL = "https://4816b0d3-d97d-47c4-a02c-298a5081c0f9.mock.pstmn.io/near/transactions"
  API_KEY = "SECRET_API_KEY"

  def self.call
    uri = URI(API_URL)
    uri.query = URI.encode_www_form(api_key: API_KEY)

    response = Net::HTTP.get_response(uri)

    if response.is_a?(Net::HTTPSuccess)
      transactions = JSON.parse(response.body)
      save_new_transactions(transactions)
    else
      Rails.logger.error("HTTP Error: #{response.code} - #{response.message}")
    end
  end

  def self.save_new_transactions(transactions)
    transfer_txs = transactions.select do |tx|
      tx["actions"].any? { |a| a["type"] == "Transfer" }
    end

    # only save new transactions
    new_txs = transfer_txs.reject do |tx|
      Transaction.exists?(tx_hash: tx["hash"])
    end

    records = new_txs.map do |tx|
      {
        sender: tx["sender"],
        receiver: tx["receiver"],
        deposit: tx["actions"].first["data"]["deposit"],
        tx_hash: tx["hash"]
      }
    end

    Transaction.insert_all(records) if records.any?
  end
end
