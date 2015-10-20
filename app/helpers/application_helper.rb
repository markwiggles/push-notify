module ApplicationHelper
 def resource_name
  :user
end

 def resource
  @resource ||= User.new
 end

 def devise_mapping
  @devise_mapping ||= Devise.mappings[:user]
 end

 def role_is_admin?
  if !current_user.nil? # if a user is logged in
   Role.find(current_user.role_id).access_level == 1 # check if admin level
  else
   false
  end
end

def role_is_member?
 if !current_user.nil? # if a user is logged in
  Role.find(current_user.role_id).access_level <= 3 # check if admin level
 else
  false
 end
end
end
