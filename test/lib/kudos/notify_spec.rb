require_relative "../../minitest_helper"

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

  it 'should know the user of the origin tweet' do
    @notify.tweet.user.screen_name.must_equal 'kenziecampbell'
    @notify.tweet.user.id.must_equal 2884181
  end

  it 'should know which screen name to send the message to'

  it "should be able to match a screen name to a User's email address"

  it 'should only send one notification per origin tweet'

end