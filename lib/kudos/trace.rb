module Kudos
  class Trace

    attr_reader :tweet, :origin

    def initialize(tweet)
      @tweet = tweet
    end

    def origin
      Twitter.status(tweet.in_reply_to_status_id)
    end

  end
end