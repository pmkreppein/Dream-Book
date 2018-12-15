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
      @dreams = Dream.all

      @user_string = "Everyone's Dreams"
      erb :'dreams/dream'
    else
      @message = 'You must be logged in to view dreams'
      erb :'users/login'
  end
  end

  get('/dreams/me') do
    if logged_in?

      @dreams = Dream.where(:user_id => current_user.id)

      @user_string = "All your Dreams, #{current_user.first_name}"

      erb :'dreams/me'
    else
      @message = 'You must be logged in to view dreams'
      erb :'users/login'
  end
  end

  get('/dreams/:id') do
    if logged_in?

      @karmas = Karma.where(:dream_id => params[:id])
      @dream = Dream.find_by_id(params[:id])
      erb :'dreams/single_dream'
    else
      @message = 'You must be logged in to create a dream'
      erb :'users/login'
  end
  end
end # classend
