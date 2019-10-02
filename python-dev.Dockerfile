FROM python:3.7-alpine

LABEL maintainer "Yefta Sutanto <yefta@bitwyre.com>"

COPY --from=bitwyre/base-images:python-alpine /app/bitwyre/base-python/wheels /app/bitwyre/base-python/wheels

COPY ./requirements/development.txt /app/bitwyre/base-python/requirements-dev.txt

WORKDIR /app/bitwyre/base-python

RUN pip install --upgrade pip wheel && \
    pip wheel -r requirements-dev.txt -w /app/bitwyre/base-python/wheels
