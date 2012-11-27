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

# TODO a site stream will allow us to dynamically add and remove users, but for now we're fixed on a single user stream.
daemon = TweetStream::Daemon.new('kudos')

daemon.on_error do |message|
  puts "TWITTER ERROR: #{message}"
end

daemon.on_reconnect do |timeout, retries|
  puts "TWITTER RECONNECTING: timeout #{timeout}, retries #{retries}"
end

daemon.on_limit do |skip_count|
  puts "TWITTER RATE LIMIT: skip #{skip_count}"
end

daemon.on_no_data_received do
  puts "TWITTER ERROR: No data received"
end

daemon.on_enhance_your_calm do
  puts "TWITTER ERROR: Enhance your calm ***"
end

daemon.userstream(:replies => 'all', :with => 'followings') do |status|
  puts "Filtering: #{status.text}"
  if Kudos::Filter.new(status).match?
    puts "Match found: #{status.text}"
    Kudos::Notify.new(Kudos::Trace.new(status).origin)
  end
end