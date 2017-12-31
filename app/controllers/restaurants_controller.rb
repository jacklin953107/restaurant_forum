class RestaurantsController < ApplicationController
	before_action :authenticate_user!
	def index
		@restaurants = Restaurant.page(params[:page]).per(9)
		@categories = Category.all
	end
	def show
		@restaurant = Restaurant.find(params[:id])
		@comment = Comment.new
	end
	def feeds
		@recent_restaurants = Restaurant.order(created_at: :desc).limit(10)
		@recent_comments = Comment.order(created_at: :desc).limit(10)
	end
	def dashboard
		@restaurant = Restaurant.find(params[:id])
	end
	def favorite
		@restaurant = Restaurant.find(params[:id])
		@restaurant.favorites.create!(user: current_user)
		redirect_back(fallback_location: root_path)
	end
	def unfavorite
		@restaurant = Restaurant.find(params[:id])
		favorite = Favorite.where(restaurant: @restaurant, user: current_user)
		favorite.destroy_all
		redirect_back(fallback_location: root_path)
	end
	def like
		@restaurant = Restaurant.find(params[:id])
		Like.create(restaurant: @restaurant, user: current_user)
		redirect_back(fallback_location: root_path)
	end
	def unlike
		@restaurant = Restaurant.find(params[:id])
		#test another way for Like.where(restaurant: @restaurant, user: current_user)
		＃like = Like.where(restaurant: @restaurant, user: current_user)
		like = @restaurant.likes.where(user: current_user)
		like.destroy_all
		redirect_back(fallback_location: root_path)
	end
end
