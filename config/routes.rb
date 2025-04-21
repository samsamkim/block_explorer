Rails.application.routes.draw do
  get "transactions/index"
  root to: "transactions#index"
end
