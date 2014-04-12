require 'bundler'
Bundler.setup :default, (ENV['RACK_ENV'] || 'development').to_sym

require 'dotenv'
Dotenv.load

require './config/environment'
require './app'

use Rack::Session::Cookie, secret: ENV['SESSION_SECRET'] || "87d8e1541e977a695aa41040f6a27f9007f84906"
use OmniAuth::Strategies::GitHub, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], scope: 'user:email'

run CommitBit::App