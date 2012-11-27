module Kudos
  class Filter

    attr_reader :tweet, :origin

    def initialize(tweet)
      @tweet = tweet
    end

    def match?
      !!(tweet.text =~ /congrats|congratulations|kudos|you|can|the/i)
    end

  end
end