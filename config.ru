require 'bundler/setup'
Bundler.require(:default)

require './service.rb'
run Sinatra::Application