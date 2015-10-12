class WelcomeController < ApplicationController

 def index
  @push_message = PushMessage.new
  @messages = PushMessage.all
 end

end
