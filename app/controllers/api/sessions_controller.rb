class Api::SessionsController < ApplicationController
  
  def create
    @user = User.includes(:channels).find_by_credentials(
      params[:user][:username],
      params[:user][:password])
    if @user
      login(@user)
      render "api/users/show"
    else
      render(
      json: ["Invalid username/password combination"],
      status: 401)
    end
  end

  def destroy
    @user = current_user
    if logged_in?
      logout
      render "api/users/show"
    else
      render(
      json: ["Nobody was logged in"],
      status: 404
      )
    end
  end

end