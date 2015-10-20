ActiveAdmin.register Role do
 menu priority: 3

 index do
  column :access_level  do |role|
   div class: 'text-center small-col' do
    role.access_level
   end
  end
  column :name
  column :description
  column  do |resource|
   create_action_icons(resource)
  end
 end

 permit_params :name, :description, :access_level
end
