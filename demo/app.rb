require 'rubygems'
require 'sinatra'
require 'haml'
require 'rest_client'
require 'crack'

SSOPHIA_BASE_URL = "http://localhost:3000"

def current_user
  session[:user]
end

get '/' do
  if params[:token]
    json = RestClient.get "#{SSOPHIA_BASE_URL}/tokens/#{params[:token]}.json"
    session[:user] = Crack::JSON.parse(json)['token']['user']
  end
  @logged = current_user and not request.cookies['ssophia'].nil?
  haml :index
end

get '/login' do
  redirect "#{SSOPHIA_BASE_URL}/users/sign_in?returnURL=http://localhost:3001"
end

get '/logout' do
  redirect "#{SSOPHIA_BASE_URL}/users/sign_out?returnURL=http://localhost:3001"
end
