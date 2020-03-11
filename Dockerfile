FROM python:3.6.1-alpine
USER root

ADD . /application

WORKDIR /application

RUN set -e; \

	apk add --no-cache --virtual .build-deps \

		gcc \

		libc-dev \

		linux-headers \

	; \

	pip install -r src/requirements.txt; \

	apk del .build-deps;

EXPOSE 5000

VOLUME /application

USER 1001
CMD uwsgi --http :5000  --manage-script-name --mount /myapplication=flask_app:app --enable-threads --processes 5
