class DreamsController < ApplicationController
  get('/dreams/new') do
    redirect_if_not_logged_in('users/login')
    erb :'dreams/new_dream'
  end

  post('/dreams/new') do
    redirect_if_not_logged_in('users/login')

    if params[:description] == '' || params[:image_link] == ''
      @message = 'Please fill form out in entirety to create dream'
      erb :'dreams/new_dream'
    else
      @dream = Dream.new(description: params[:description],
                         image_link: params[:image_link],
                         user_id: current_user.id)
      @dream.save

      redirect to "/dreams/#{@dream.id}"

  end
  end

  get('/dreams') do
    redirect_if_not_logged_in('users/login')
    @dreams = Dream.all
    @user_string = "Everyone's Dreams"
    erb :'dreams/dream'
    # else
    #   @message = 'You must be logged in to view dreams'
    #   erb :'users/login'
  end

  get('/dreams/me') do
    redirect_if_not_logged_in('users/login')

    @dreams = Dream.where(user_id: current_user.id) # current_user.dreams

    @user_string = "All your Dreams, #{current_user.first_name}"

    erb :"dreams/me"
  end

  get('/dreams/:id') do
    redirect_if_not_logged_in('users/login')

    @karmas = Karma.where(dream_id: params[:id])
    @dream = Dream.find_by_id(params[:id])
    erb :'dreams/single_dream'
  end

  get('/dreams/:id/edit') do
    @dream = Dream.find_by_id(params[:id])
    if @dream.user_id == current_user.id
      erb :'dreams/edit'
    else
      @message = 'You are unable to edit someone elses dream!'
      erb :error
    end
  end

  patch('/dreams/:id/edit') do
    redirect_if_not_logged_in('users/login')
    if params[:description] == '' || params[:image_link] == ''
      redirect to "/dreams/#{params[:id]}/edit"
    else
      @dream = Dream.find_by_id(params[:id])
      if @dream && @dream.user_id == current_user.id
        if @dream.update(description: params[:description], image_link: params[:image_link])
          redirect to "/dreams/#{@dream.id}"
        else
          redirect to "/dreams/#{@dream.id}/edit"
        end
      else
        @message = 'You are unable to change another users dreams!'
        erb :error
      end

  end
  end

  delete('/dreams/:id/delete') do
    redirect_if_not_logged_in('users/login')
    @dream = Dream.find_by_id(params[:id])

    if @dream && @dream.user_id == current_user.id
      @dream.delete
      redirect to '/'
    else
      erb :error
  end
  end

  helpers do
    def redirect_if_not_logged_in(destination)
      redirect to "/#{destination}" unless logged_in?
   end
  end
end # classend
