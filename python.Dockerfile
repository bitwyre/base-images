FROM python:3.7-alpine

LABEL maintainer "Yefta Sutanto <yefta@bitwyre.com>"

COPY --from=bitwyre/base-images:grpc-alpine /app/bitwyre/base-grpc/wheels /app/bitwyre/base-python/wheels

COPY ./requirements/bitwyre.txt /app/bitwyre/base-python/requirements.txt

WORKDIR /app/bitwyre/base-python

RUN apk --no-cache add --virtual build-deps \
        gcc \
        g++ \
        libstdc++ \
        libffi-dev \
        librdkafka-dev \
        openblas-dev \
        build-base \
        lapack-dev \
        musl-dev \
        openssl-dev && \
    apk --no-cache add \
        py3-scipy && \
    pip install --upgrade pip wheel && \
    pip wheel -r requirements.txt -w /app/bitwyre/base-python/wheels && \
    apk --no-cache del build-deps && \
    rm -rf /var/cache/apk/*
    
ENV PYTHONPATH=/usr/lib/python3.7/site-packages
