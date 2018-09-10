Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post :create, to: 'posts#create'
  get  :top,    to: 'posts#top'
  post :rate,   to: 'rates#create'
  get  :ips,    to: 'users#index'
end
