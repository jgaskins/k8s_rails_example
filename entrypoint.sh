#!/bin/sh

npm install -g yarn && yarn && bundle exec rails assets:precompile
