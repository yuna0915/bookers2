class UsersController < ApplicationController
  def index
    @users = User.all
    @books = current_user.books
    @book = Book.new
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      flash[:alert] = "User not found."
      redirect_to users_path
    else
      @books = @user.books
      @book = Book.new
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
    if @user.nil?
      flash[:alert] = "User not found."
      redirect_to users_path
    end
  end

  protected

  def update
    @user = User.find_by(id: params[:id])
    if @user.nil?
      flash[:alert] = "User not found."
      redirect_to users_path
    elsif @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user)
    else
      flash.now[:alert] = "Failed to update user."
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
