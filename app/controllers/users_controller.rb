class UsersController < ApplicationController

  get('/users/create-account'){
    erb :'users/create_account'
  }

  post('/users/create_account'){

  if !User.find_by(:email => params[:email])
      if params[:username] == "" || params[:email] == "" || params[:password] == "" || params[:first_name] == ""
        @message = "Sorry, you need to fill out the form in its entirety to sign up."
        erb :'users/create_account'
    else
       @user = User.new(:username => params[:username], :email => params[:email], :first_name => params[:first_name], :password => params[:password])
       @user.save
       binding.pry
       session[:user_id] = @user.id
       redirect to '/dreams/me'
     end
  else
     @message = "Looks like you already have an account with us, or another error took place."
     erb :'users/create_account'
  end
}

get('/users/login'){
  if !logged_in?
    erb :'users/login'
  else
    redirect to '/dreams'
  end
}

post('/users/login'){

  user = User.find_by(:email => params[:email])

  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect to '/dreams/me'
  else
    @message = "Sorry, either your username or password was invalid.  Try again."
    erb :'users/login'
  end
}

get('/logout'){
  if logged_in?
    session.destroy
    redirect to '/'
  else
    redirect to '/'
  end

}
end #classend
