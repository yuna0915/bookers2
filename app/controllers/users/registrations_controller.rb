# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    flash[:notice] = "Welcome! You have signed up successfully."
    super(resource)
  end

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

  # Strong parameters (ユーザーのパラメータを許可)
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
