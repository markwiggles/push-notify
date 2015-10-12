#
# GCM.host = 'https://android.googleapis.com/gcm/send'
# # # https://android.googleapis.com/gcm/send is default
# #
# GCM.format = :json
# # # :json is default and only available at the moment
# #
# GCM.key = 'AIzaSyBrmDYAPzdyMKXms2I3ro0ePD8WdUH2Hqo'
# # # this is the apiKey obtained from here https://code.google.com/apis/console/
# #
# #

require 'gcm'

gcm = GCM.new("AIzaSyBrmDYAPzdyMKXms2I3ro0ePD8WdUH2Hqo")
