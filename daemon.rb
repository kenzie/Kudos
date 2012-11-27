# Kudos! Stream Processing

require 'bundler/setup'
require 'tweetstream'
require_relative './lib/kudos'

$stdout.sync = true

TweetStream.configure do |config|
  config.consumer_key       = ENV['TWITTER_KEY']
  config.consumer_secret    = ENV['TWITTER_SECRET']
  config.oauth_token        = ENV['OAUTH_TOKEN']
  config.oauth_token_secret = ENV['OAUTH_TOKEN_SECRET']
  config.auth_method        = :oauth
end

# TODO a user stream will allow us to dynamically add and remove users, but for now we're fixed on a single user.
client = TweetStream::Daemon.new('kudos').on_error { |message| puts "TWITTER ERROR: #{message}" }

client.userstream(:with => 'followings', :replies => 'all') do |status|
  puts "Filtering: #{status.text}"
  if Kudos::Filter.new(status).match?
    puts "Match found: #{status.text}"
    Kudos::Notify.new(Kudos::Trace.new(status).origin)
  end
end