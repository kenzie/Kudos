module Kudos
  class Trace

    attr_reader :tweet, :origin

    def initialize(tweet)
      @tweet = tweet
    end

    def origin
      Twitter.status(tweet.in_reply_to_status_id) if tweet.reply?
    end

    #   begin
    #     ...
    #   rescue Twitter::Error::Forbidden
    #     # ignore forbidden tweets
    #   rescue Twitter::Error::TooManyRequests
    #     abort "Twitter API rate limit exceeded"
    #   end

  end
end