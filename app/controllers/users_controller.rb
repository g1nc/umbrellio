class UsersController < ApplicationController
  def index
    render json: { ips: User.users_ip(params[:user_ids].split(',')) }
  end
end
