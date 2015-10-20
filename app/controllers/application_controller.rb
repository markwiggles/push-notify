class ApplicationController < ActionController::Base
 # Prevent CSRF attacks by raising an exception.
 # For APIs, you may want to use :null_session instead.
 protect_from_forgery with: :exception

 def authenticate_user!
  if user_signed_in?
   super
  else
   redirect_to welcome_index_path
  end
 end

 def authenticate_admin_user!
  if !current_user.nil? # if a user is logged in
   redirect_to root_path unless Role.find(current_user.role_id).access_level == 1 # check if admin level
  else
   redirect_to root_path
  end
end

 def after_sign_in_path_for(_resource)
  member_index_path(current_user) # path after sign in
 end
end
