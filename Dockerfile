FROM python:3.6.1-alpine
USER root
ENV APP_ROOT=/application

ADD . ${APP_ROOT}
COPY ./src ${APP_ROOT}
WORKDIR ${APP_ROOT}
RUN set -e; \

	apk add --no-cache --virtual .build-deps \

		gcc \

		libc-dev \

		linux-headers \

	; \

	pip install -r src/requirements.txt; \

	apk del .build-deps;

EXPOSE 5000

VOLUME ${APP_ROOT}

USER 1001

CMD uwsgi --http :5000  --manage-script-name --mount /application=flask_app:app --enable-threads --processes 5
