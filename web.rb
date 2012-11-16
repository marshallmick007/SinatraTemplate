require 'sinatra'
require 'sinatra/base'
require 'open-uri'
require 'rack/ssl'

# Load any DEV environment variables
require File.join(File.dirname(__FILE__), 'config', 'development_env') if development?

require File.join(File.dirname(__FILE__), 'helpers', 'helpers')
require File.join(File.dirname(__FILE__), 'models', 'models')
require File.join(File.dirname(__FILE__), 'routes', 'routes')

class SinatraApp < Sinatra::Base
  helpers Sinatra::FormBuilder

  ## From https://github.com/sinatra/sinatra-recipes/blob/master/app.rb
  #configure :production do
  #  sha1, date = `git log HEAD~1..HEAD --pretty=format:%h^%ci`.strip.split('^')
  #
  #  require 'rack/cache'
  #  use Rack::Cache
  #
  #  before do
  #    cache_control :public, :must_revalidate, :max_age=>300
  #    etag sha1
  #    last_modified date
  #  end
  #end

  #
  # Force SSL - http://opensoul.harmonyapp.com/blog/archives/2011/11/16/sinatra-and-ssl/
  #
  use Rack::SSL if !development?

  configure :production do
    set :raise_errors, false
    set :show_exceptions, false
  end

  configure :development do
    # Need :sessions for development, heroku doesnt like it: https://gist.github.com/1017771
    enable :sessions
    # Tell sinatra not to use a different session secret on each application restart
    set :session_secret, 'super secret'

    set :dump_errors => true, :show_exceptions => true
  end

  configure do
    enable :logging
    set :root, File.dirname(__FILE__)

  end

  before do
    if mobile_request?
      set :erb, :layout => :mobile
    else
      set :erb, :layout => :layout
    end

  end

  after do

  end

  error do
    e = request.env['sinatra.error']
    Kernel.puts e.backtrace.join("\n")
    'Application error'
  end
end


