module Kudos
  class StreamMonitor

     # TODO handle errors, rate limits, etc.

    def track
      stream.track('congrats', 'congratulations', 'kudos') { |status| Match.new(status).notify! if status.reply? }
    end

    private

    def stream
      TweetStream::Client.new.on_error { |message| puts "TWITTER ERROR: #{message}" }
    end

  end
end