module Kudos

  require 'bundler/setup'
  require 'twitter'
  require 'yaml'

  require_relative 'kudos/filter'
  require_relative 'kudos/trace'
  require_relative 'kudos/notify'

  Twitter.configure do |config|
    config.consumer_key       = ENV['TWITTER_KEY']
    config.consumer_secret    = ENV['TWITTER_SECRET']
    config.oauth_token        = ENV['OAUTH_TOKEN']
    config.oauth_token_secret = ENV['OAUTH_TOKEN_SECRET']
  end

end