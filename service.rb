# Kudos!

configure do
  set :haml, { :format => :html5 }
end

configure(:development) do |c|
  require 'sinatra/reloader'
  also_reload './lib/*.rb'
end

get '/' do
  expires 3600, :public
  haml :index
end