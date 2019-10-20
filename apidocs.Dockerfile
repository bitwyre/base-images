FROM ruby:2.6.5-alpine

LABEL maintainer "Yefta Sutanto <yefta@bitwyre.com>"

RUN apk --no-cache add --update g++ make nodejs

COPY ./gemfiles /app/bitwyre/apidocs

WORKDIR /app/bitwyre/apidocs

RUN gem install bundler
RUN bundle install
