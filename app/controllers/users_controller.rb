class UsersController < ApplicationController
	before_action :authenticate_user!, only: [:edit, :update, :destroy, :close]
  def new
  	@user=User.new
  end

  def edit
  @user = current_user

  end

  def show
  	@user = User.find_by_username(params[:username])
  end

  def create
  	@user=User.new(user_params)
  	if @user.save
  	session[:user_id] = @user.id
  	redirect_to username_path(@user.username), notice: "New account created"
  	else
  	render :new
  	end
  end

  def update
  	@user = current_user
  	if @user.update(user_params)
  		redirect_to username_path(@user.username), notice: "Profile Updated"
  	else
  		render :edit
  	end
  end	

  def destroy
  	@user = current_user
	  	if @user.password == params[:users][:password]
	  	@user.destroy
	  	session[:user_id]= nil
	  	redirect_to root_path, notice: "Your account has been deleted"
	  else
	  	flash[:alert] = "Wrong passwor. Having second Thoughts :) ?"
		render :close
	  end
  end

  	def close
  	end

  private

  def user_params
  	params.require(:user).permit(:username, :email, :lname, :fname, :password, :password_confirmation)
  	
  end

end











