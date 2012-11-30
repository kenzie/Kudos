module Kudos
  class Filter

    attr_reader :tweet

    def initialize(tweet)
      @tweet = tweet
    end

    def match?
      return false unless tweet
      !!(tweet.text =~ /congrats|congratulations|kudos/i)
    end

  end
end