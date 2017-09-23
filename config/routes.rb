Rails.application.routes.draw do
  root "csv_uploads#index"

  resources :csv_uploads, only: [:index, :new, :create]
  resources :state_trackers, only: [:new, :create]
end
