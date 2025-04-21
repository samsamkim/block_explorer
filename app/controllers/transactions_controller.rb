class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.order(tx_time: :desc)
  end
end
