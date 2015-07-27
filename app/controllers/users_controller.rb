class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end
  
  def update
    @user = User.find(params[:id])
    @user.assign_attributes(user_params)
    if @user.save
      flash[:success] = "更新完了です！"
      redirect_to @user
    else
      flash[:danger] = "更新できませんでした。"
      render 'edit'
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
