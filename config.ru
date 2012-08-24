# this needs to be first
if (ENV['RACK_ENV'] || :development) == :development
  require 'rack-livereload'
  require "sinatra/reloader" 
  use Rack::LiveReload, :min_delay => 500 
end

require File.join(File.dirname(__FILE__), 'web')

set :environment, ENV['RACK_ENV'] || :development

use Rack::Deflater
use Rack::Session::Cookie

run SinatraApp
