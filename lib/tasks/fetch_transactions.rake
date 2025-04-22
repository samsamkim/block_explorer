namespace :near do
  desc "Fetch latest NEAR transfer transactions and save them"

  task fetch_transactions: :environment do
    puts "Fetching NEAR transactions..."
    FetchNearTransactions.call
    puts "Finished fetching NEAR transactions"
  end
end
