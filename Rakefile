#!/usr/bin/env rake

# REF: http://jasonseifer.com/2010/04/06/rake-tutorial

require 'less'
require File.join(File.dirname(__FILE__), 'config', 'development_env')

task :default => 'compile:all'

namespace :stage do
  desc "Sets the build number"
  task :stampbuild do
    # perhaps create an ENV and use the heroku gem to set/update it?
    puts "TODO: create a way to stash the git build number to heroku(if using)"
  end
end

namespace :compile do

  desc "Compiles all assets"
  task :all => [:less, :coffee] do

  end

  desc "Compiles coffee-scripts files"
  task :coffee do
    #http://andrewberls.com/blog/post/rakefile-to-build-coffeescript-projects
    puts "TODO: coffeescript compilation"
  end

  desc "Compiles less files"
  task :less do
    begin
      import_paths = []
      import_paths << ENV['LESS_IMPORT_PATH']
      lessfiles = Dir.glob(ENV['LESS_ASSET_DIR'] + "/*.less")
      lessfiles.each do |lessfile|
        cssfile = File.join(ENV['CSS_OUTPUT_DIR'], File.basename(lessfile).gsub(/\.less$/, '.css'))
        parser = Less::Parser.new :paths => import_paths, :filename => lessfile
        
        File.open(lessfile,'r') do |infile|
          File.open(cssfile,'w') do |outfile|
            tree = parser.parse(infile.read)
            outfile << tree.to_css(:compress => true)
          end
        end
      end

    rescue Exception => e
      puts "less compilation failed #{e.message}"
    end
  end

end
