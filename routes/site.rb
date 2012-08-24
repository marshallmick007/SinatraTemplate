
#
# Contains all routes to browser accessible pages
#
class SinatraApp < Sinatra::Base
  
  get "/" do
    erb :index
  end

end
