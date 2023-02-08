# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  #before_action :authorize_admin, only: [:destroy_user]

  def after_sign_in_path_for(resource)
    projects_path
    #if resource.admin == true
      #'/user_admin'
    #else
      #projects_path
    #end
  end

  def admin
  end

  def authorize_admin
    unless current_user.admin == true
      redirect_to root_path, alert: "You do not have permission to delete user"
    end
  end

  def destroy_user
    if current_user.admin == true
      @user = User.find(params[:id])
      @user.destroy
      redirect_to home_show_path, notice: "User has been deleted successfully"
    end
  end

  def remove_from_admin
    if current_user.admin == true
      @user = User.find(params[:id])
      #@user.update(admin: false)
      @user.admin = false
      @user.save
      redirect_to home_show_path
    end
  end


  def add_admin
    if current_user.admin == true
      @user = User.find(params[:id])
      @user.admin = true
      @user.save
      redirect_to home_show_path
    end
  end
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
