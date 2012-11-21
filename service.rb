# Kudos!

configure do
  set :haml, { :format => :html5 }
  TWITTER = YAML.load_file(File.expand_path("../config/twitter.yml", __FILE__)) unless defined? TWITTER
  use Rack::Session::Pool, :expire_after => 2592000
end

configure(:development) do |c|
  require 'sinatra/reloader'
  also_reload './lib/*.rb'
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
  access_token = session[:request_token].get_access_token
  screen_name = access_token.params[:screen_name]
  oauth_token = access_token.params[:oauth_token]
  oauth_token_secret = access_token.params[:oauth_token_secret]
  "Screen Name: #{screen_name} <br/> Access Token: #{oauth_token} <br/> Access Token Secret: #{oauth_token_secret}"
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