Rails.application.routes.draw do

  
  devise_for :users, :controllers => { registrations: 'registrations' }, :path => 'auth' 
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount Ckeditor::Engine => '/ckeditor'
  
  #, :controllers => { registrations: 'registrations' }, :path => 'auth' 
  #  controllers: {confirmations: 'confirmations'}

  resources :lectures do
    member do
    get "download", to: "lectures#download", as: "download_lecture"
    end
  end
  resources :lectures do
    member do
      get "spam" , to: "lectures#spam", as: "spam"
    end
  end
  resources :lectures do
    member do
      put "like" => "lectures#vote"
    end
  end
  resources :lectures do
    resources :comments
  end
  resources :courses
  resources :users
  root 'users#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
