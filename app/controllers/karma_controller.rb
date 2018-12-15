class KarmaController < ApplicationController
  post('/karma/add/:id'){

    @karma = Karma.new(:user_id => current_user.id, :dream_id => params[:id], :karma_comment => params[:karma])
    @karma.save
    redirect to "/dreams/#{params[:id]}"
  }
end
