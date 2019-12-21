FROM ruby:2.6.5-alpine3.10

ARG RAILS_ENV
ARG RAILS_MASTER_KEY

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

RUN bundle exec rake assets:precompile

EXPOSE 3000

ENV RAILS_ENV ${RAILS_ENV}
ENV RAILS_MASTER_KEY ${RAILS_MASTER_KEY}

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
