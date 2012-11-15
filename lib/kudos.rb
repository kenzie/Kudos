module Kudos

  require 'tweetstream'
  require 'twitter'
  require 'yaml'

  require_relative 'kudos/stream_monitor'
  require_relative 'kudos/match'
  require_relative 'kudos/notify'

  TWITTER = YAML.load_file(File.expand_path("../../config/twitter.yml", __FILE__)) unless defined? TWITTER

  TweetStream.configure do |config|
    config.consumer_key       = TWITTER['consumer_key']
    config.consumer_secret    = TWITTER['consumer_secret']
    config.oauth_token        = TWITTER['oauth_token']
    config.oauth_token_secret = TWITTER['oauth_token_secret']
    config.auth_method        = :oauth
  end

  Twitter.configure do |config|
    config.consumer_key       = TWITTER['consumer_key']
    config.consumer_secret    = TWITTER['consumer_secret']
    config.oauth_token        = TWITTER['oauth_token']
    config.oauth_token_secret = TWITTER['oauth_token_secret']
  end

end