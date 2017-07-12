FROM ruby:2.4.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /torcidalegal
WORKDIR /torcidalegal
ADD Gemfile /torcidalegal/Gemfile
ADD Gemfile.lock /torcidalegal/Gemfile.lock
RUN bundle install
ADD . /torcidalegal