FROM python:3.7-alpine

LABEL maintainer "Yefta Sutanto <yefta@bitwyre.com>"

COPY --from=bitwyre/base-images:grpc-alpine /app/bitwyre/base-grpc/wheels /app/bitwyre/base-python/wheels

COPY ./requirements/bitwyre.txt /app/bitwyre/base-python/requirements.txt

WORKDIR /app/bitwyre/base-python

RUN echo "http://dl-8.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

# Add HDF5 support
RUN apk add --no-cache --allow-untrusted --repository http://dl-3.alpinelinux.org/alpine/edge/testing hdf5 hdf5-dev
RUN apk --no-cache --update-cache add gcc gfortran python python-dev py-pip build-base wget freetype-dev libpng-dev openblas-dev
RUN ln -s /usr/include/locale.h /usr/include/xlocale.h
RUN apk --no-cache add --virtual build-deps \
        g++ \
        libffi-dev \
        librdkafka-dev \
        openssl-dev && \
    pip install --upgrade pip wheel && \
    pip wheel -r requirements.txt -w /app/bitwyre/base-python/wheels && \
    apk --no-cache del build-deps && \
    rm -rf /var/cache/apk/*
