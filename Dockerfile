# Dockerfile

FROM phusion/passenger-ruby22:latest

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Copy the Gemfile and Gemfile.lock into the image.
# Temporarily set the working directory to where they are.
WORKDIR /tmp
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install

# Add the Rails app from the current directory to /myapp w- permissions
# Add the Rails app
ADD . /home/app/webapp
RUN chown -R app:app /home/app/webapp

WORKDIR /home/app/webapp
RUN RAILS_ENV=production rake assets:precompile

# Expose Nginx HTTP service
# EXPOSE 80

# Start Nginx / Passenger
RUN rm -f /etc/service/nginx/down
# Remove the default site
RUN rm /etc/nginx/sites-enabled/default
# Add the nginx site and config
ADD nginx.conf /etc/nginx/sites-enabled/webapp.conf
ADD rails-env.conf /etc/nginx/main.d/rails-env.conf

# Clean up APT and bundler when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
