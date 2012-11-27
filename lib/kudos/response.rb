module Kudos
  class Response

    attr_reader :response

    def initialize(raw_response)
      @response = MultiJson.load(raw_response, :symbolize_keys => true)
    end

    def tweet?
      response.has_key? :text
    end

    def reply?
      !response[:in_reply_to_status_id].nil?
    end

    def process!
      return false unless tweet? && reply?
      tweet = Twitter::Tweet.new(response)
      puts "Filtering... #{tweet.text}"
      if Kudos::Filter.new(tweet).match?
        puts "Match found!"
        Kudos::Notify.new(Kudos::Trace.new(tweet).origin).send!
      else
        puts "No match."
      end
    end

  end
end