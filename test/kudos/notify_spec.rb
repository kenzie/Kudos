require_relative "../minitest_helper"

describe Kudos::Notify do

  before do
    @tweet = Twitter.status(266265329125179392)
    @notify = Notify.new(@tweet)
  end

  it 'should compose a link to the originating tweet' do
    @notify.status_link.must_equal "http://twitter.com/kenziecampbell/status/266265329125179392"
  end

  it 'should compose a notification message' do
    @notify.message.must_match /Kudos Match/
  end

end