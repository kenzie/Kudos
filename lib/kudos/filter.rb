module Kudos
  class Filter

    attr_reader :tweet, :origin

    def initialize(tweet)
      @tweet = tweet
    end

    def match?
      !!(tweet.text =~ /congrats|congratulations|kudos/i)
    end

    # def notify!
    #   begin
    #     Notify.new(origin).send!
    #   rescue Twitter::Error::Forbidden
    #     # ignore forbidden tweets
    #   rescue Twitter::Error::TooManyRequests
    #     abort "Twitter API rate limit exceeded"
    #   end
    # end

  end
end