Ssophia::Application.routes.draw do
  devise_for :users, :controllers => { :sessions => "sessions" }
  resources :tokens
  root :to => "application#index"
end
