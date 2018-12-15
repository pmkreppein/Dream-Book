class UsersController < ApplicationController

  get('/users/create-account'){
    erb :'users/create_account'
  }

  post('/users/create_account'){
  if params[:username] == "" || params[:email] == "" || params[:password] == "" || params[:first_name] == ""
    redirect to '/users/create_account'
  else
     @user = User.new(:username => params[:username], :email => params[:email], :first_name => params[:first_name], :password => params[:password])
     @user.save
     session[:user_id] = @user.id
     redirect to '/dreams/me'
  end
}

get('/login'){
  if !logged_in?
    erb :'users/login'
  else
    redirect to '/dreams'
  end
}


end #classend
