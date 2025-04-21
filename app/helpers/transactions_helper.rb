module TransactionsHelper
  def number_with_delimiter(number)
    ActionController::Base.helpers.number_with_delimiter(number)
  end
end
