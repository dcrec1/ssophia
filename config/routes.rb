Ssophia::Application.routes.draw do
  devise_for :users, :controllers => { :sessions => "sessions" }
end
