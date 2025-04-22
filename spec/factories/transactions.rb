FactoryBot.define do
  factory :transaction do
    sequence(:tx_hash) { |n| "txhash#{n}" }
    sender { "sender_1" }
    receiver { "receiver_2" }
    deposit { "1000000000000000000000000" }
  end
end
