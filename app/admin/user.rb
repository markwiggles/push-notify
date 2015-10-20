ActiveAdmin.register User do
 menu priority: 2

 permit_params :name, :email, :role_id, :password, :password_confirmation

 index do
  column 'Access Level' do |user|
   Role.find(user.role_id).name
  end
  column :name
  column :email
  column  do |resource|
   create_action_icons(resource)
  end
 end


 form do |f|
  f.inputs 'New User' do
   f.input :name
   f.input :email
   f.input :role_id, as: :select, prompt: '--select a role--', collection: Role.pluck(:name, :id)
   f.input :password
   f.input :password_confirmation
  end
  f.actions
 end
end
