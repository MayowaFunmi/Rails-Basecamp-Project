Rails.application.routes.draw do
  #devise_for :users
  resources :projects
  get 'home/show'
  get 'home/profile_page'
  #get 'users/sessions/admin'
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'home#index'
  # set custom path for admin page
  devise_scope :user do
    get 'user_admin', to: 'users/sessions#admin'
    #delete 'destroy', to: 'users/sessions#destroy'
    get 'destroy_user/:id' => "users/sessions#destroy_user"
    get 'remove_from_admin/:id' => "users/sessions#remove_from_admin"
    get 'add_admin/:id' => "users/sessions#add_admin"
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
