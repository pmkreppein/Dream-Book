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
    if params[:description] == '' || params[:image_link] == ''
      @message = "Please fill form out in entirety to create dream"
      erb :'dreams/new_dream'
    else if logged_in?
      @dream = Dream.new(description: params[:description],
                         image_link: params[:image_link],
                         user_id: current_user.id)
      @dream.save
      @dreams << @dream
      @message = 'Dream created successfully'
      redirect to "/dreams/me"
    else
      @message = 'You must be logged in to create a dream'
      erb :'users/login'
  end
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

      @dreams = Dream.where(user_id: current_user.id)

      @user_string = "All your Dreams, #{current_user.first_name}"

      erb :'dreams/me'
    else
      @message = 'You must be logged in to view dreams'
      erb :'users/login'
  end
  end

  get('/dreams/:id') do
    if logged_in?

      @karmas = Karma.where(dream_id: params[:id])
      @dream = Dream.find_by_id(params[:id])
      erb :'dreams/single_dream'
    else
      @message = 'You must be logged in to create a dream'
      erb :'users/login'
  end
  end

  get('/dreams/edit/:id') do
    @dream = Dream.find_by_id(params[:id])
    if @dream.user_id == current_user.id
      erb :'dreams/edit'
    else
      @message = 'You are unable to edit someone elses dream!'
      erb :error
    end
  end

  patch('/dreams/edit/:id') do
    if params[:description] == '' || params[:image_link] == ''
      redirect to "/dreams/edit/#{params[:id]}"
  else if logged_in?
      @dream = Dream.find_by_id(params[:id])
      if @dream && @dream.user_id == current_user.id
        if @dream.update(description: params[:description], image_link: params[:image_link])
          redirect to "/dreams/#{@dream.id}"
        else
          redirect to "/dreams/edit/#{@dream.id}"
        end
      else
        @message = 'You are unable to change another users dreams!'
        erb :error
      end
    else
      puts 'not logged on'
      redirect to '/login'
    end
  end
end

  delete('/dreams/delete/:id') do
    if logged_in?
      @dream = Dream.find_by_id(params[:id])

      if @dream && @dream.user_id == current_user.id
        @dream.delete
        redirect to '/'
      else
        erb :error
    end
    else
      redirect to '/login'
    end
  end
end # classend
