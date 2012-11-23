# Kudos!

configure do
  set :haml, { :format => :html5 }
  use Rack::Session::Cookie, :expire_after => 31536000, :secret => 'Kudo Monger'
end

configure(:production) do |c|
  TWITTER = {}
  TWITTER['consumer_key'] = ENV['TWITTER_KEY']
  TWITTER['consumer_secret'] = ENV['TWITTER_SECRET']
end

configure(:development) do |c|
  TWITTER = YAML.load_file(File.expand_path("../config/twitter.yml", __FILE__)) unless defined? TWITTER
  require 'sinatra/reloader'
  also_reload './lib/*.rb'
  set :redis , 'redis://127.0.0.1:6379/5'
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
  user = User.create(screen_name, oauth_token, oauth_token_secret)
  session[:screen_name] = screen_name
  redirect '/success'
end

get '/success' do
  @user = User.find(session[:screen_name])
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

class User
  attr_reader :screen_name, :oauth_token, :oauth_token_secret
  def initialize screen_name, oauth_token, oauth_token_secret
    @screen_name, @oauth_token, @oauth_token_secret = screen_name, oauth_token, oauth_token_secret
  end
  def self.create screen_name, oauth_token, oauth_token_secret
    user = self.new screen_name, oauth_token, oauth_token_secret
    user.save
    user
  end
  def self.find screen_name
    if redis.sismember "users", "#{screen_name}"
      oauth_token = redis.get "#{screen_name}:token"
      oauth_token_secret = redis.get "#{screen_name}:secret"
      self.new screen_name, oauth_token, oauth_token_secret
    else
      false
    end
  end
  def save
    redis.sadd "users", "#{@screen_name}"
    redis.set "#{@screen_name}:token", "#{@oauth_token}"
    redis.set "#{@screen_name}:secret", "#{@oauth_token_secret}"
    true
  end
  def to_s
    "#User > screen_name: #{screen_name}, oauth_token: #{oauth_token}, oauth_token_secret: #{oauth_token_secret}"
  end
end
