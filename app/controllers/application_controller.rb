require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :views, 'app/views'
    enable :sessions
    set :session_secret, '6AC3C336E4094835293A3FED8A4B5FEDDE1B5E2626D9838FED50693BBA00AF0E'
  end

  get('/')  do
    if logged_in?
      redirect to '/dreams'
    else
      erb :index
    end
  end

  helpers do
    def logged_in?
      !!current_user
    end # logged_in end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def user_name_by_id(id)
      User.find_by_id(id).username
    end
  end # helpers end
end # class end
