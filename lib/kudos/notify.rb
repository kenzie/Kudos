module Kudos
  class Notify

    # TODO queue notifications

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

    # def notify!
    #   begin
    #     ...
    #   rescue Twitter::Error::Forbidden
    #     # ignore forbidden tweets
    #   rescue Twitter::Error::TooManyRequests
    #     abort "Twitter API rate limit exceeded"
    #   end
    # end

  end
end