require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it "is valid with valid attributes" do
    expect(build(:transaction)).to be_valid
  end

  it "is invalid without a tx_hash" do
    tx = build(:transaction, tx_hash: nil)
    expect(tx).not_to be_valid
  end

  it "does not allow duplicate tx_hash" do
    create(:transaction, tx_hash: "abc123")
    expect(build(:transaction, tx_hash: "abc123")).not_to be_valid
  end
end
