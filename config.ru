require 'bundler/setup'
Bundler.require(:default)

require './lib/service.rb'
run Sinatra::Application