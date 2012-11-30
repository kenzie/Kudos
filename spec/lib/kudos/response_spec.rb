require_relative "../../spec_helper"

describe Kudos::Response do

  before do
    @friends_json = '{"friends":[14246143,24533922,115485051,12534]}'
    @reply_json  = %q[{"text":"@zeldman The quick brown dog jumped over the lazy fox.","id_str":"273458810042077184","geo":null,"created_at":"Tue Nov 27 16:10:35 +0000 2012","in_reply_to_status_id_str":"273449400200753152","coordinates":null,"source":"\u003Ca href=\"http:\/\/itunes.apple.com\/us\/app\/twitter\/id409789998?mt=12\" rel=\"nofollow\"\u003ETwitter for Mac\u003C\/a\u003E","in_reply_to_user_id_str":"61133","entities":{"urls":[],"user_mentions":[{"indices":[0,8],"id_str":"61133","name":"Jeffrey Zeldman","screen_name":"zeldman","id":61133},{"indices":[24,33],"id_str":"646533","name":"Eric A. Meyer","screen_name":"meyerweb","id":646533}],"hashtags":[]},"retweeted":false,"in_reply_to_screen_name":"zeldman","contributors":null,"place":null,"in_reply_to_user_id":61133,"in_reply_to_status_id":273449400200753152,"truncated":false,"user":{"profile_background_tile":false,"profile_sidebar_fill_color":"DDEEF6","id_str":"505943647","created_at":"Mon Feb 27 14:47:30 +0000 2012","is_translator":false,"listed_count":0,"profile_sidebar_border_color":"C0DEED","url":"http:\/\/ilnickistudios.com","description":"","friends_count":47,"default_profile":true,"lang":"en","profile_use_background_image":true,"profile_image_url":"http:\/\/a0.twimg.com\/profile_images\/1857783631\/Screen_Shot_2012-02-27_at_9.39.59_AM_normal.png","verified":false,"geo_enabled":false,"profile_text_color":"333333","location":"","statuses_count":168,"profile_background_image_url_https":"https:\/\/si0.twimg.com\/images\/themes\/theme1\/bg.png","profile_background_image_url":"http:\/\/a0.twimg.com\/images\/themes\/theme1\/bg.png","protected":false,"following":null,"profile_link_color":"0084B4","name":"Ilnicki Studios","default_profile_image":false,"notifications":null,"followers_count":15,"screen_name":"IlnickiStudios","id":505943647,"follow_request_sent":null,"contributors_enabled":false,"time_zone":null,"utc_offset":null,"favourites_count":1,"profile_background_color":"C0DEED","profile_image_url_https":"https:\/\/si0.twimg.com\/profile_images\/1857783631\/Screen_Shot_2012-02-27_at_9.39.59_AM_normal.png"},"retweet_count":0,"id":273458810042077184,"favorited":false}]
    @tweet_json  = %q[{"text":"The quick brown fox jumped over the lazy dog.","id_str":"273458810042077184","geo":null,"created_at":"Tue Nov 27 16:10:35 +0000 2012","in_reply_to_status_id_str":null,"coordinates":null,"source":"\u003Ca href=\"http:\/\/itunes.apple.com\/us\/app\/twitter\/id409789998?mt=12\" rel=\"nofollow\"\u003ETwitter for Mac\u003C\/a\u003E","in_reply_to_user_id_str":null,"entities":{"urls":[],"user_mentions":[{"indices":[0,8],"id_str":"61133","name":"Jeffrey Zeldman","screen_name":"zeldman","id":61133},{"indices":[24,33],"id_str":"646533","name":"Eric A. Meyer","screen_name":"meyerweb","id":646533}],"hashtags":[]},"retweeted":false,"in_reply_to_screen_name":null,"contributors":null,"place":null,"in_reply_to_user_id":null,"in_reply_to_status_id":null,"truncated":false,"user":{"profile_background_tile":false,"profile_sidebar_fill_color":"DDEEF6","id_str":"505943647","created_at":"Mon Feb 27 14:47:30 +0000 2012","is_translator":false,"listed_count":0,"profile_sidebar_border_color":"C0DEED","url":"http:\/\/ilnickistudios.com","description":"","friends_count":47,"default_profile":true,"lang":"en","profile_use_background_image":true,"profile_image_url":"http:\/\/a0.twimg.com\/profile_images\/1857783631\/Screen_Shot_2012-02-27_at_9.39.59_AM_normal.png","verified":false,"geo_enabled":false,"profile_text_color":"333333","location":"","statuses_count":168,"profile_background_image_url_https":"https:\/\/si0.twimg.com\/images\/themes\/theme1\/bg.png","profile_background_image_url":"http:\/\/a0.twimg.com\/images\/themes\/theme1\/bg.png","protected":false,"following":null,"profile_link_color":"0084B4","name":"Ilnicki Studios","default_profile_image":false,"notifications":null,"followers_count":15,"screen_name":"IlnickiStudios","id":505943647,"follow_request_sent":null,"contributors_enabled":false,"time_zone":null,"utc_offset":null,"favourites_count":1,"profile_background_color":"C0DEED","profile_image_url_https":"https:\/\/si0.twimg.com\/profile_images\/1857783631\/Screen_Shot_2012-02-27_at_9.39.59_AM_normal.png"},"retweet_count":0,"id":273458810042077184,"favorited":false}]
  end

  it "#tweet? returns true for tweets" do
    Response.new(@reply_json).tweet?.must_equal true
  end

  it "#tweet? returns false for non-tweets" do
    Response.new(@friends_json).tweet?.must_equal false
  end

  it "#reply? returns true for replies" do
    Response.new(@reply_json).reply?.must_equal true
  end

  it "#reply? returns false for non-replies" do
    Response.new(@tweet_json).reply?.must_equal false
  end

  it "#tweet returns a Twitter::Tweet" do
    Response.new(@reply_json).tweet.text.must_equal "@zeldman The quick brown dog jumped over the lazy fox."
  end

end