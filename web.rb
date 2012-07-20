require 'sinatra'
require 'sinatra/base'
require 'nokogiri'
require 'open-uri'

class SinatraApp < Sinatra::Base

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

  configure do

  end

  before do

  end

  after do

  end

  get "/" do
    erb :index
  end

  error do
    e = request.env['sinatra.error']
    Kernel.puts e.backtrace.join("\n")
    'Application error'
  end

  helpers do
    #
    # Allows for partial views
    #
    def partial(name, options={})
      erb("_#{name.to_s}".to_sym, options.merge!(:layout => false))
    end

    #
    # Decorator function for proteted pages
    #
    def protected!
      unless authorized?
        response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
        throw(:halt, [401, "Not authorized\n"])
      end
    end

    def authorized?
      @auth ||=  Rack::Auth::Basic::Request.new(request.env)
      @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == ['username', 'pass']
    end
  end

end
