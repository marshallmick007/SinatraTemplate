require File.join(File.dirname(__FILE__), 'config', 'development_env')

# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'livereload' do
  watch(%r{views/.+\.(erb|haml)})
  watch(%r{public/js/.+\.(js)})
  watch(%r{public/css/.+\.(css)})
  # Rails Assets Pipeline
  #watch(%r{(app|vendor)/assets/\w+/(.+\.(css|js|html)).*})  { |m| "/assets/#{m[2]}" }
end

# https://github.com/netzpirat/guard-coffeescript
guard 'coffeescript', :input => 'assets/coffee', :output => 'public/js'

# https://github.com/guard/guard-pow#readme
guard 'pow' do
  watch('.powrc')
  watch('Gemfile')
  watch('Gemfile.lock')
  watch('config/*.rb')
  watch('web.rb')
  watch('config.ru')
  watch('lib/**/*.rb')
  watch(%r{^helpers/.*\.rb$})
  watch(%r{^models/.*\.rb$})
  watch(%r{^routes/.*\.rb$})
end


# https://github.com/guard/guard-sass
guard 'sass', :all_on_start => true, 
              #:load_paths => [ ENV['SASS_IMPORT_PATH'] ],
              :compass => true,
              :output => "public/css" do
  watch(%r{^assets/sass/.+\.s[ac]ss$})
  #watch(%r{^assets/scss/inc/.+\.s[as]ss$})
end
