FROM python:3.8.0-alpine

LABEL maintainer "Yefta Sutanto <yefta@bitwyre.com>"

COPY ./requirements/grpc.txt /app/bitwyre/base-grpc/requirements.txt

WORKDIR /app/bitwyre/base-grpc

RUN apk --no-cache add --virtual build-deps g++ musl-dev && \
    pip install --upgrade pip wheel && \
    pip wheel -r requirements.txt -w /app/bitwyre/base-grpc/wheels && \
    apk --no-cache del build-deps && \
    rm -rf /var/cache/apk/*
