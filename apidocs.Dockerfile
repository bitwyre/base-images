FROM ruby:2.7-alpine

LABEL maintainer "Yefta Sutanto <yefta@bitwyre.com>"

RUN apk --no-cache add --update g++ make nodejs libxml2-dev libxslt-dev

COPY ./gemfiles /app/bitwyre/apidocs

WORKDIR /app/bitwyre/apidocs

RUN gem install bundler
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install
