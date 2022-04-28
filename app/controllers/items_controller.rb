class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  
  def show
    item = Item.find(params[:id])
    if item 
    render json: item, include: :user
    else 
      items = Item.all
      render json: items
    end
  end

  def index 
    if params[:user_id]
      user = find_user
      items = user.items
    else 
      items = Item.all
    end 
    render json: items, include: :user
  end

  def create 
    user = find_user
    if user 
      item = user.items.create(permit_params)
      render json: item, status: :created
    end 
  end 

  private

  def permit_params 
    params.permit(:name, :description, :price)
  end 
  def find_user 
    User.find(params[:user_id])
  end 
  def render_not_found_response
    render json: { error: "Item house not found" }, status: :not_found
  end

  def bad_creation
    render json: {success: "item not created"}, status: :created
  end 
end
