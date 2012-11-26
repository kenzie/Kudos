require 'bundler/setup'
require 'tweetstream'
require_relative './lib/kudos'

TWITTER = YAML.load_file(File.expand_path("../config/twitter.yml", __FILE__)) unless defined? TWITTER

TweetStream.configure do |config|
  config.consumer_key       = TWITTER['consumer_key']
  config.consumer_secret    = TWITTER['consumer_secret']
  config.oauth_token        = TWITTER['oauth_token']
  config.oauth_token_secret = TWITTER['oauth_token_secret']
  config.auth_method        = :oauth
end

client = TweetStream::Daemon.new('kudos').on_error { |message| puts "TWITTER ERROR: #{message}" }

client.userstream do |status|
  Kudos::Notify.new(status).process if Kudos::Filter.new(status).match?
end