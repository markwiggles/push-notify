class API::V1::UsersController < ApplicationController
 protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
 skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }

 def index
  users = User.all
  render json: users
 end

 def create
  user = User.new(user_params)
  if user.save
   render json: user, status: 201
  else
   render json: 'sorry device not registered', status: 400
  end
 end

 private

 def user_params
  params.require(:user).permit(
   :name,
   :email,
   :password,
   devices_attributes: [:token, :platform, :enabled]
  )
 end
end
