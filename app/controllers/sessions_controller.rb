class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email params[:email]
   
    if user&.authenticate params[:password]
      session[:user_id] = user.id
      flash[:success] = "User Logged In"
      redirect_to recipes_path
    else
      flash[:warning] = "Please Check your Credentials"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to recipes_path
  end
   
end