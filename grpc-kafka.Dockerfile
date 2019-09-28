FROM python:3.7-alpine

LABEL maintainer "Yefta Sutanto <yefta@bitwyre.com>"

COPY --from=bitwyre/base-images:grpc-alpine /app/bitwyre/base-grpc/venv /app/bitwyre/base-grpc-kafka/venv

COPY ./requirements/kafka.txt /app/bitwyre/base-grpc-kafka/requirements.txt

ENV PATH="/app/bitwyre/base-grpc-kafka/venv/bin:$PATH"

WORKDIR /app/bitwyre/base-grpc-kafka

RUN apk --no-cache add --virtual build-deps g++ librdkafka-dev && \
    pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt && \
    apk --no-cache del build-deps
