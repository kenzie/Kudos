module Kudos
  class Notify

    attr_reader :tweet

    def initialize(tweet)
      @tweet = tweet
    end

    def send!
      puts "#{message}: #{status_link}"
    end

    def status_link
      "http://twitter.com/#{tweet.user.screen_name}/status/#{tweet.id}"
    end

    def message
      "Kudos Match!"
    end

  end
end