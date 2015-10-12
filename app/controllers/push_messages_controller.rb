class PushMessagesController < ApplicationController
 include PushMessagesHelper

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
end
