Rails.application.routes.draw do
  root "csv_uploads#index"

  resources :csv_uploads, only: [:index, :new, :create]
end
