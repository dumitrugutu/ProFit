Rails.application.routes.draw do
  root to: "dashboards#index"

  devise_for :users, controllers: { registrations: 'registrations' }
  
  resources :users do
    resources :workouts
  end
end
