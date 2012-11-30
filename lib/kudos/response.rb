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

    def tweet
      Twitter::Tweet.new(response) if tweet?
    end

  end
end