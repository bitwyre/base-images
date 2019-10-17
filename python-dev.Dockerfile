FROM python:3.8.0-alpine

LABEL maintainer "Yefta Sutanto <yefta@bitwyre.com>"

COPY --from=bitwyre/base-images:python-alpine /app/bitwyre/base-python/wheels /app/bitwyre/base-python/wheels

COPY ./requirements/development.txt /app/bitwyre/base-python/requirements-dev.txt

WORKDIR /app/bitwyre/base-python

RUN apk --no-cache add --virtual build-deps \
        g++ && \
    pip install --upgrade pip wheel && \
    pip wheel -r requirements-dev.txt -w /app/bitwyre/base-python/wheels && \
    apk --no-cache del build-deps && \
    rm -rf /var/cache/apk/*
