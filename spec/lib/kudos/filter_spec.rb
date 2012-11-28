require_relative "../../spec_helper"

describe Kudos::Filter do

  before do
    @tweet1 = Twitter::Tweet.new(:id => 266272346032205824, :in_reply_to_screen_name => 'kenziecampbell', :in_reply_to_status_id => 266265329125179392, :text => 'Congrats on your new thing!')
    @tweet2 = Twitter::Tweet.new(:id => 266272346032205824, :in_reply_to_screen_name => 'kenziecampbell', :in_reply_to_status_id => 266265329125179392, :text => 'Hey, how is it going?')
  end

  it "#match? returns true for matching kudos tweets" do
    Filter.new(@tweet1).match?.must_equal true
  end

  it "#match? returns false for non-matching kudos tweets" do
    Filter.new(@tweet2).match?.must_equal false
  end

end