FROM ruby:3.0.2-alpine

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

COPY Gemfile Gemfile.lock package.json yarn.lock /myapp/
RUN gem install bundler
RUN bundle install -j12
RUN npm install -g yarn
RUN yarn

COPY . /myapp
RUN bundle exec rake assets:precompile

# Start the main process.
CMD ["rails", "server"]
