
  Rails.application.routes.draw do
  namespace :api do
    resources :companies, only: [:index, :show, :create, :update, :destroy]
  end
end

