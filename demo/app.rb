require 'rubygems'
require 'sinatra'
require 'haml'
require 'rest_client'

SSOPHIA_BASE_URL = "http://localhost:3000"

get '/' do
  @logged = if params[:token]
    true
  else
    url = "#{SSOPHIA_BASE_URL}/sessions/#{request.cookies["_session_id"]}.json"
    RestClient.head(url).status == 200
  end
  haml :index
end

get '/login' do
  redirect "#{SSOPHIA_BASE_URL}/users/sign_in?returnURL=http://localhost:3001"
end

get '/logout' do
  redirect "#{SSOPHIA_BASE_URL}/users/sign_out?returnURL=http://localhost:3001"
end
