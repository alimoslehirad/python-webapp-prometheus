FROM python:3.6.1-alpine
USER root
ENV APP_ROOT=/opt/app-root

ADD . ${APP_ROOT}
COPY ./src/flask_app.py ${APP_ROOT}
COPY src/helpers/ ${APP_ROOT}
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
CMD uwsgi --http :5000  --wsgi-file flask_app.py --enable-threads --processes 5
