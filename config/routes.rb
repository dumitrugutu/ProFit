Rails.application.routes.draw do
  root to: "dashboards#index"

  devise_for :users, controllers: { registrations: 'registrations' }

  get "dashboards/search" => "dashboards#search", as: "search_dashboards"

  resources :users do
    resources :workouts
  end
end
