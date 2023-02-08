class HomeController < ApplicationController
  layout "application"
  #before_action :authenticate_user!
  def index
  end

  def show
    @users = User.all
  end

  def profile_page
    @user = current_user
  end
end
