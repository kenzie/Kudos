require "bundler/setup"
require "minitest/autorun"
require "Ohm"
require_relative "../../lib/user"

Ohm.connect(:url => 'redis://127.0.0.1:6379/9')

describe User do

  before do
    Ohm.redis.flushdb
    @user = User.create(:screen_name => 'kenziecampbell')
  end

  it "shouldn't allow duplicate screen names" do
    create_duplicate = lambda { User.create(:screen_name => 'kenziecampbell') } 
    create_duplicate.must_raise Ohm::UniqueIndexViolation
  end

  it "should be able to save an email address" do
    @user.email = 'kenzie@route19.com'
    @user.save
    User.find(:screen_name => 'kenziecampbell').first.email.must_equal 'kenzie@route19.com'
  end

  it "#find_by_screen_name" do
    User.find_by_screen_name('kenziecampbell').must_equal @user
  end

end