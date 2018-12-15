class DreamsController < ApplicationController


  get('/dreams/new') do
    if logged_in?
      erb :'dreams/new_dream'
    else
      @message = 'You must be logged in to create a dream'
      erb :'users/login'
  end
  end

  post('/dreams/new') do
    @dreams = []
    if logged_in?
        @dream = Dream.new(:description => params[:description],
        :image_link => params[:image_link],
        :user_id => current_user.id
      )
      @dream.save
      @dreams << @dream
      @message = "Dream created successfully"
      erb :'dreams/dream'
    else
      @message = 'You must be logged in to create a dream'
      erb :'users/login'
  end
  end

  get('/dreams') do
    if logged_in?
      @dreams = Dream.all(:user_id => current_user.id)

      erb :'dreams/dream'
    else
      @message = 'You must be logged in to view dreams'
      erb :'users/login'
  end
  end

  get('/dreams/me') do
    @dreams = []
    if logged_in?

      @dreams = Dream.where(:user_id => current_user.id)

      @user_string = "All your Dreams, #{current_user.first_name}"
      erb :'dreams/dream'
    else
      @message = 'You must be logged in to view dreams'
      erb :'users/login'
  end
  end

  get('/dreams/members/:username') do
    if logged_in?
      erb :'dreams/me'
    else
      @message = 'You must be logged in to create a dream'
      erb :'users/login'
  end
  end
end # classend
