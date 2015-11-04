ActiveAdmin.register PushMessage do
 permit_params :message, :response, :additional

 config.clear_action_items!

 index do
  column :message
  column :additional

 end


end
