class UsersController < ApplicationController
  before_action :set_user, only:[:show,:edit,:update, :friend_list]
  def index
    @users = User.all
  end
  def show
    @commented_restaurants = @user.restaurants
    @favorited_restaurants = @user.favorited_restaurants
    @followings = @user.followings
    @followers = @user.followers
  end
  def edit
    unless @user == current_user
      redirect_to user_path(@user)
    end
  end
  def update
    @user.update(user_params)
    redirect_to user_path(@user)
  end
  def friend
    @user = User.find(params[:id])
    Friendship.create(user:current_user,friend:@user)
    flash[:notice] = "Successfully friended"
    redirect_back(fallback_location: users_path)
  end
  def unfriend
    @user = User.find(params[:id])
    user = Friendship.where(user:current_user,friend:@user)
    user.destroy_all
    flash[:alert] = "Friend destroyed"
    redirect_back(fallback_location: users_path)
  end
  def friend_list
    unless @user == current_user
      redirect_to user_path(@user)
    end
  end


  private
  def set_user
    @user= User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:name,:intro,:avatar)
  end
end
