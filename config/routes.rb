Ssophia::Application.routes.draw do
  devise_for :users, :controllers => { :sessions => "sessions" } do
    match "/sessions/:id" => "sessions#show"
  end
  resources :tokens
  root :to => "application#index"
end
