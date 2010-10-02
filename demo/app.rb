require 'rubygems'
require 'sinatra'
require 'haml'
require 'rest_client'

SSOPHIA_BASE_URL = "http://localhost:3000"

get '/' do
  @logged = if params[:token]
    true
  else
    not request.cookies['ssophia'].nil?
  end
  haml :index
end

get '/login' do
  redirect "#{SSOPHIA_BASE_URL}/users/sign_in?returnURL=http://localhost:3001"
end

get '/logout' do
  redirect "#{SSOPHIA_BASE_URL}/users/sign_out?returnURL=http://localhost:3001"
end
