class DreamsController < ApplicationController

get('/dreams/me'){
  if logged_in?
  erb :'dreams/me'
else
  redirect to '/users/login'
end
}




end #classend
