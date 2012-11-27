module Kudos
  class Filter

    attr_reader :tweet, :origin

    def initialize(tweet)
      @tweet = tweet
    end

    def match?
      !!(tweet.text =~ /congrats|congratulations|kudos/i)
    end

  end
end