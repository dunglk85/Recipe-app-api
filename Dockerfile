FROM python:3.9-alpine3.13
LABEL maintainer="dunglk85"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
#COPY ./scripts /scripts
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ENV DEV=false
RUN python -m venv /py && \
    apk update && \
    apk add --no-cache build-base linux-headers && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user && \
ENV PATH="/py/bin:$PATH"

USER django-user

CMD ["run.sh"]
