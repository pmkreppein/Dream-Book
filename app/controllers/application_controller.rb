require './config/environment'

class ApplicationController < Sinatra::Base
    configure do 
        set :views, 'app/views'
    end

    get('/'){
        "Hello World!"
    }

end #class end