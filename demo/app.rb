require 'rubygems'
require 'sinatra'
require 'haml'
require 'rest_client'
require 'crack'
require 'ruby-debug'

enable :sessions

SSOPHIA_BASE_URL = "http://localhost:3000"

def create_user_session
  begin
    json = RestClient.get "#{SSOPHIA_BASE_URL}/tokens/#{params[:token]}.json"
    session[:user] = Crack::JSON.parse(json)['token']['user']
    session[:ssophia] = request.cookies['ssophia']
  rescue
  end
end

def current_user
  session[:user]
end

def cookie_exists?
  not request.cookies['ssophia'].nil?
end

def cookie_did_change?
  request.cookies['ssophia'] != session[:ssophia]
end

def logged?
  current_user and cookie_exists? and not cookie_did_change?
end

get '/' do
  create_user_session if params[:token]
  @logged = logged?
  haml :index
end

get '/login' do
  redirect "#{SSOPHIA_BASE_URL}/users/sign_in?returnURL=http://localhost:3001/"
end

get '/logout' do
  redirect "#{SSOPHIA_BASE_URL}/users/sign_out?returnURL=http://localhost:3001/"
end
