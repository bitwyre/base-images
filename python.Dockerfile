FROM python:3.7-alpine

LABEL maintainer "Yefta Sutanto <yefta@bitwyre.com>"

COPY --from=bitwyre/base-images:grpc-alpine /app/bitwyre/base-grpc/wheels /app/bitwyre/base-python/wheels

COPY ./requirements/bitwyre.txt /app/bitwyre/base-python/requirements.txt
COPY ./requirements/extras.txt /app/bitwyre/base-python/requirements-extras.txt

WORKDIR /app/bitwyre/base-python

RUN apk --no-cache add --virtual build-deps \
        g++ \
        libffi-dev \
        librdkafka-dev \
        openssl-dev && \
    pip install --upgrade pip wheel && \
    pip wheel -r requirements.txt -w /app/bitwyre/base-python/wheels && \
    pip wheel -r requirements-extras.txt -w /app/bitwyre/base-python/wheels && \
    apk --no-cache del build-deps && \
    rm -rf /var/cache/apk/*
