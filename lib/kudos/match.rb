module Kudos
  class Match

    # TODO do we have to go further up the tree if this is a reply to a reply...?
    # TODO persist a list of already-notified-on origins
    # TODO handle forbidden/unauthorized origins

    attr_reader :tweet, :origin

    def initialize(tweet)
      @tweet = tweet
    end

    def origin
      Twitter.status(tweet.in_reply_to_status_id)
    end

    def notify!
      Notify.new(origin).send!
    end

  end
end