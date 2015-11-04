ActiveAdmin.register Device do
 permit_params :token, :platform, :enabled, :user_id

 index do
  column 'User' do |device|
   User.find(device.user_id).name
  end
  column 'Email' do |device|
   User.find(device.user_id).email
  end
  column :platform
  column :enabled
  column  do |resource|
   create_action_icons(resource)
  end
 end

 form do |f|
  inputs 'New Device' do
    f.input :user_id, as: :select, prompt: '--select a user--', collection: User.pluck(:name, :id)
    f.input :platform, as: :select, prompt: '--select a platform--', collection: ['iOS', 'Android']
    f.input :token
  end
 end
end
