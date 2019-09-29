FROM python:3.7-alpine

LABEL maintainer "Yefta Sutanto <yefta@bitwyre.com>"

COPY ./requirements/grpc.txt /app/bitwyre/base-grpc/requirements.txt

RUN python -m venv /app/bitwyre/base-grpc/venv
ENV PATH="/app/bitwyre/base-grpc/venv/bin:$PATH"

WORKDIR /app/bitwyre/base-grpc

RUN apk --no-cache add --virtual build-deps g++ musl-dev && \
    pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt && \
    apk --no-cache del build-deps
