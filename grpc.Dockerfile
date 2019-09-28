FROM python:3.7-alpine as base

LABEL maintainer "Yefta Sutanto <yefta@bitwyre.com>"

# ---- compile image ----
FROM base AS compile-image

COPY ./requirements/grpc.txt /app/bitwyre/base/requirements.txt

RUN python -m venv /app/bitwyre/base/venv
ENV PATH="/app/bitwyre/base/venv/bin:$PATH"

WORKDIR /app/bitwyre/base

RUN apk --no-cache add --virtual build-deps git g++ musl-dev && \
    pip install --no-cache-dir -r requirements.txt && \
    apk --no-cache del build-deps
