class Transaction < ApplicationRecord
  validates :tx_hash, presence: true, uniqueness: true

  # In case we want to store all transactions and scope by transfers in the future
  #
  # scope :transfers, -> { where("actions @> ?", [{ type: "Transfer" }].to_json) }
end
