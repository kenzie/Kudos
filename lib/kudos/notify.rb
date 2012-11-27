module Kudos
  class Notify

    # TODO queue notifications

    attr_reader :tweet

    def initialize(tweet)
      @tweet = tweet
    end

    def send!
      puts "SENDING NOTIFICATION: #{message}: #{status_link}"
    end

    def status_link
      "http://twitter.com/#{tweet.user.screen_name}/status/#{tweet.id}"
    end

    def message
      "Kudos Match!"
    end

  end
end