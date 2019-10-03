FROM ruby:2.6.5-alpine3.10

ARG APP_DOMAIN

RUN apk add --update \
  libxml2-dev \
  build-base \
  linux-headers \
  git \
  postgresql-dev \
  nodejs \
  npm \
  tzdata

RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN gem install bundler
RUN bundle install -j12
RUN npm install -g yarn
COPY . /myapp
RUN yarn

RUN rake assets:precompile

EXPOSE 3000

# Expose app domain to the app for Rails 6 DNS-rebinding attack protection
ENV APP_DOMAIN ${APP_DOMAIN}

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
