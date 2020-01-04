# frozen_string_literal: true

class UserController < ApplicationController
  def index; end

  def create
    if User.find_by(name: user_params[:name])
      render(json: { message: ' User already exists with the given name! Please use a different one ! ' }, status: 422) && return
    end
    user = User.create(name: user_params[:name])
    render json: { message: 'User create successfully', user: user }, status: 200
  rescue StandardError => e
    render json: { message: "Cannot create user! #{e.message}" }, status: 500
  end

  def show
    user = User.find_by(name: user_params[:name])
    render json: { user: user }, status: 200
  rescue StandardError => e
    render json: { message: "Cannot fetch user! #{e.message}" }, status: 500
  end

  def update
    user = User.find_by(name: user_params[:name])
    user.update_attributes(name: user_params[:name])
    user.save!
  rescue StandardError => e
    render json: { message: "Cannot update user! #{e.message}" }, status: 500
  end

  def destroy
    User.find(user_params[:id])&.destroy
    render(json: { massage: 'User destroyed successfully!' }, status: 200) && return
  rescue StandardError => e
    render json: { message: "User with given ID does not exist! #{e.message}" }, status: 422
  end

  private

  def user_params
    params.permit(:id, :name)
  end
end
