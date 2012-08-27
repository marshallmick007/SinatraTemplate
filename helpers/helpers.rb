require File.join(File.dirname(__FILE__), 'form_builder')

class SinatraApp < Sinatra::Base
  helpers do
    #Credit to Lachlan Hardy, taken from this blog post originally:
    #http://lachstock.com.au/code/mobile-pages-in-sinatra/
    def mobile_user_agent_patterns
      [
        /AppleWebKit.*Mobile/,
        /Android.*AppleWebKit/
      ]
    end

    #
    # Is this a mobile request?
    #
    def mobile_request?
      mobile_user_agent_patterns.any?{ |r|
        request.env['HTTP_USER_AGENT'] =~ r
      }
    end

    #
    # Allows for partial views
    #
    def partial(name, options={})
      erb("_#{name.to_s}".to_sym, options.merge!(:layout => false))
    end

    #Flash helper based on the one from here:
    #https://github.com/daddz/sinatra-dm-login/blob/master/helpers/sinatra.rb
    #Call in your views like so:
    #<% if session[:flash] %>
    # <p><%= show_flash(:flash) %></p>
    #<% end %>
    def show_flash(key)
      if session[key]
        flash = session[key]
        session[key] = false
        flash
      end
    end

    #
    # Set a flash message
    #
    def flash(msg)
      session[:flash] = msg
    end

    #
    # Decorator function for proteted pages
    #
    def protected!
      unless authorized_basic?
        response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
        throw(:halt, [401, "Not authorized\n"])
      end
    end

    #
    # Requests HTTP Basic authentication
    #
    def authorized_basic?
      @auth ||=  Rack::Auth::Basic::Request.new(request.env)
      @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == ['username', 'pass']
    end

    #
    # Determines the build
    #
    def build_version
      if development? || ENV['BUILD_VERSION'].nil?
        sha1, date = `git log HEAD~1..HEAD --pretty=format:%h^%ci`.strip.split('^')
      else
        sha1, date = ENV['BUILD_VERSION'], ENV['BUILD_DATE']
      end
    end
  end

end
