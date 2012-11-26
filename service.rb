# Kudos!

configure do
  require './lib/user'
  set :haml, { :format => :html5 }
  use Rack::Session::Cookie, :expire_after => 31536000, :secret => 'Kudo Monger'
end

configure(:production) do |c|
  TWITTER = { 'consumer_key' => ENV['TWITTER_KEY'], 'consumer_secret' => ENV['TWITTER_SECRET'] }
  Ohm.connect(:url => ENV["REDISTOGO_URL"])
end

configure(:development) do |c|
  TWITTER = YAML.load_file(File.expand_path("../config/twitter.yml", __FILE__)) unless defined? TWITTER
  require 'sinatra/reloader'
  also_reload './lib/*.rb'
  Ohm.connect(:url => 'redis://127.0.0.1:6379/0')
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
  # TODO handle denied authorization
  access_token = session[:request_token].get_access_token
  screen_name = access_token.params[:screen_name]
  oauth_token = access_token.params[:oauth_token]
  oauth_token_secret = access_token.params[:oauth_token_secret]
  user = User.create(:screen_name => screen_name, :oauth_token => oauth_token, :oauth_token_secret => oauth_token_secret)
  session[:screen_name] = screen_name
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
  OAuth::Consumer.new( TWITTER['consumer_key'], TWITTER['consumer_secret'], :site => 'https://api.twitter.com' )
end

def redirect_uri
  uri = URI.parse(request.url)
  uri.path = '/auth/twitter/callback'
  uri.query = nil
  uri.to_s
end
