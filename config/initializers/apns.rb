


# APNS.host = "gateway.push.apple.com"
# # APNS.pem = "#{Rails.root}/npsr_production.pem"
# APNS.pem = "#{Rails.root}/certificates/oneapp-push-certificate.pem"
# APNS.port = 2195

# APNS.host = "gateway.sandbox.push.apple.com"
# APNS.pem = "#{Rails.root}/pt_development.pem"

#OR
# APNS.pem = File.join(Rails.root, "production.pem")

# Set the environment variable `APPLE_SANDBOX` to use the development certificate in production
# if Rails.env.production? && !ENV["APPLE_SANDBOX"]
#   APNS.host = "gateway.push.apple.com"
#   APNS.pem = File.join(Rails.root, "production.pem")
# end
