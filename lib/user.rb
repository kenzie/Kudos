class User < Ohm::Model

  attribute :screen_name
  attribute :oauth_token
  attribute :oauth_token_secret
  attribute :email

  index :screen_name
  unique :screen_name

  def self.find_by_screen_name(screen_name)
    find(:screen_name => screen_name).first
  end

end