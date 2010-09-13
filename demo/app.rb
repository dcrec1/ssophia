require 'rubygems'
require 'sinatra'
require 'haml'
require 'open-uri'

get '/' do
  @logged = if params[:token]
    true
  else

  end
  haml :index
end

get '/login' do
  redirect 'http://localhost:3000/users/sign_in?returnURL=http://localhost:3001'
end

get '/logout' do
  redirect 'http://localhost:3000/users/sign_out?returnURL=http://localhost:3001'
end
