class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.order(block_height: :desc)
  end
end
