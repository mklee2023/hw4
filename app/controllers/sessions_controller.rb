class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by({ "email" => params["email"] })
    if @user
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] = @user["id"]
        flash["notice"] = "Welcome, #{@user["username"]}"
        redirect_to "/places"
      else
        flash["notice"] = "Unsuccessful login. Check your password again"
        redirect_to "/sessions/new"
      end
    else
      flash["notice"] = "Unseccessful login. Check your email again"
      redirect_to "/sessions/new"
    end
  end

  def destroy
    flash["notice"] = "Goodbye."
    session["user_id"] = nil
    redirect_to "/sessions/new"
  end
end
  