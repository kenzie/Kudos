require_relative "../minitest_helper"

describe Kudos::Match do

  before do
    @tweet = Twitter::Tweet.new(:id => 266272346032205824, :in_reply_to_screen_name => 'kenziecampbell', :in_reply_to_status_id => 266265329125179392)
    @match = Match.new(@tweet)
  end

  it "should fetch the matched originating tweet (via REST API)" do
    @match.origin.id.must_equal @tweet.in_reply_to_status_id
    @match.origin.text.must_equal "Those geese have the V shape right, but they're headed East!"
  end

end