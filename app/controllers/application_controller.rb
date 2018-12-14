require './config/environment'

class ApplicationController < Sinatra::Base
    configure do 
        set :views, 'app/views'
        enable :sessions
        set :session_secret, '6AC3C336E4094835293A3FED8A4B5FEDDE1B5E2626D9838FED50693BBA00AF0E'
    end

    get('/'){
        erb :index
    }

    helpers do
        def logged_in?
            !!current_user
        end #logged_in end
    end #helpers end

end #class end