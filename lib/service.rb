# Kudos! Website

configure do
  require_relative './user'
  set :haml, { :format => :html5 }
  use Rack::Session::Cookie, :expire_after => 31536000, :secret => 'Kudo Monger'
  Ohm.connect(:url => ENV["REDISTOGO_URL"] || ENV["REDIS_URL"])
end

configure(:development) do |c|
  require 'sinatra/reloader'
  also_reload './user.rb'
end


get '/' do
  expires 3600, :public
  haml :index
end

get '/auth/twitter' do
  puts "Redirect URL: #{redirect_uri}"
  request_token = client.get_request_token(:oauth_callback => redirect_uri)
  session[:request_token] = request_token
  redirect request_token.authorize_url(:oauth_callback => redirect_uri)
end

get '/auth/twitter/callback' do
  redirect '/' if params[:denied]
  screen_name, oauth_token, oauth_token_secret = set_oauth_tokens
  session[:screen_name] = screen_name
  user = User.find_by_screen_name(screen_name) || User.create(:screen_name => screen_name, :oauth_token => oauth_token, :oauth_token_secret => oauth_token_secret)
  redirect '/email'
end

get '/email' do
  @user = User.find_by_screen_name(session[:screen_name])
  haml :email
end

post '/email' do
  email = params[:email]
  redirect '/email' if email == ''
  @user = User.find_by_screen_name(session[:screen_name])
  @user.email = email
  @user.save
  redirect '/success'
end

get '/success' do
  @user = User.find_by_screen_name(session[:screen_name])
  haml :success
end


def client
  OAuth::Consumer.new( ENV['TWITTER_KEY'], ENV['TWITTER_SECRET'], :site => 'https://api.twitter.com' )
end

def redirect_uri
  uri = URI.parse(request.url)
  uri.path = '/auth/twitter/callback'
  uri.query = nil
  uri.to_s
end

def set_oauth_tokens
  access_token = session[:request_token].get_access_token
  screen_name = access_token.params[:screen_name]
  oauth_token = access_token.params[:oauth_token]
  oauth_token_secret = access_token.params[:oauth_token_secret]
  [screen_name, oauth_token, oauth_token_secret]
end