class PushWorker
 include Sidekiq::Worker

 require 'gcm'

 def perform(push_message_id)

	 push_message = PushMessage.find(push_message_id)
  #-------------------------------------------------------------------------------
  #  GOOGLE CLOUD MESSAGING SERVICE
  android_devices = Device.where(enabled: true, platform: 'android')
  registrations = [] # create an array of registration tokens
  android_devices.each do |device|
   registrations.push device.token
  end

  options = { data: {
   title: 'hello one app LED',
   message: push_message.message,
   ledColor: [0, 0, 255, 0], notId: DateTime.now.to_i } }

  gcm = GCM.new('AIzaSyAnui6vkf4PG6j7TEDhBqETmU2cbCnmzIc')
  gcm_response = gcm.send(registrations, options) # send the GCM messages
  #-------------------------------------------------------------------------------
  # APPLE NOTIFICATION SERVICE
  ios_devices = Device.where(enabled: true, platform: 'iOS')

  logger.debug("IOS DEVICES: #{ios_devices}")

  ios_devices.each do |device|
   notification = Grocer::Notification.new(
    device_token:      device.token,
    alert:             push_message.message,
    custom: { name: 'additional item', type: 'type is variable' }
   )

   pusher = connect_apns # connect to apns and send the message
   apns_response = pusher.push(notification) # return value is the number of bytes sent successfully
  end
   # ,
   # badge:             42,
   # category:          "a category",         # optional; used for custom notification actions
   # sound:             "siren.aiff",         # optional
   # expiry:            Time.now + 60*60,     # optional; 0 is default, meaning the message is not stored
   # identifier:        1234,                 # optional; must be an integer
   # content_available: true,                  # optional; any truthy value will set 'content-available' to 1
  end

 private

 def connect_apns
  pusher = Grocer.pusher(
   certificate: "#{Rails.root}/certificates/oneapp-push-certificate.pem",      # required
   passphrase:  '',                       # optional
   gateway:     'gateway.push.apple.com', # optional; See note below.
   port:        2195,                     # optional
   retries:     3                         # optional
  )
 end
end
