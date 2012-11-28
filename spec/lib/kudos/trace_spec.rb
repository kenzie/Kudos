require_relative "../../spec_helper"

describe Kudos::Trace do

  before do
    # test origin + reply: https://twitter.com/kenziecampbell/status/266265329125179392
    @reply_tweet  = Twitter.status(266272346032205824)
    @origin_tweet = Twitter.status(266265329125179392)
    @trace = Trace.new(@reply_tweet)
  end

  it "should fetch the matched originating tweet (via REST API)" do
    @trace.origin.must_equal @origin_tweet
    @trace.origin.text.must_equal "Those geese have the V shape right, but they're headed East!"
  end

end