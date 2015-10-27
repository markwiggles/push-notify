class PushMessagesController < ApplicationController
 before_action :check_if_admin

 def index
  @push_message = PushMessage.new
  @messages = PushMessage.all
 end

 def new
  push_message = PushMessage.new
 end

 def create
  push_message = PushMessage.new(push_params)
  if push_message.save # save and send to sidekiq worker
   PushWorker.perform_async(push_message.id)
   redirect_to welcome_index_path
  else
   redirect_to welcome_index_path
  end
 end

 private

 def push_params
  params.require(:push_message).permit(
   :title,
   :message,
   :additional,
   :response
  )
 end

 def check_if_admin
  if !current_user.nil? # if a user is logged in
   redirect_to root_path unless Role.find(current_user.role_id).access_level == 1 # check if admin level
  else
   redirect_to root_path
  end
end
end
