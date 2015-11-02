FROM phusion/passenger-ruby22:latest

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init system, so we can run multiple processes
CMD ["/sbin/my_init"]

# Copy the Gemfile and Gemfile.lock into the image.
# Temporarily set the working directory to where they are.
WORKDIR /tmp
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install

# Add the Rails app from the current directory to /webapp w- permissions
ADD . /home/app/webapp
RUN sudo mkdir -p tmp/pids
RUN chown -R app:app /home/app/webapp && chmod -R u+rwX  tmp/pids/
RUN mkdir /home/app/webapp/log && touch /home/app/webapp/log/production.log && \
chmod -R 664 /home/app/webapp/log/production.log

WORKDIR /home/app/webapp
RUN RAILS_ENV=production rake assets:precompile

# Start Nginx / Passenger
RUN rm -f /etc/service/nginx/down
# Remove the default site & add the nginx info for our site, inc. env variables
RUN rm /etc/nginx/sites-enabled/default
ADD nginx.conf /etc/nginx/sites-enabled/webapp.conf
ADD rails-env.conf /etc/nginx/main.d/rails-env.conf


# Clean up APT and bundler when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Publish port
EXPOSE 80
