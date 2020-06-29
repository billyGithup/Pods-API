Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :teams do
    member do
      get 'list_employees'
      post 'add_employee'
    end
  end

  resources :employees
end