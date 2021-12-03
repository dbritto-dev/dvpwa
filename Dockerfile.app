FROM python:alpine3.8
RUN apk add --no-cache wget \
    && wget -O /usr/bin/wait-for https://raw.githubusercontent.com/eficode/wait-for/master/wait-for \
    && chmod +x /usr/bin/wait-for \
    && apk del wget
COPY requirements.txt /tmp
RUN apk add --no-cache --virtual build-deps gcc python3-dev musl-dev postgresql-dev \
    && apk add --no-cache libpq \
    && python -m pip install --upgrade pip \
    && python -m pip install -U -r /tmp/requirements.txt \
    && apk del build-deps
RUN rm -rf /tmp/requirements.txt1

WORKDIR /app
COPY ./run.py /app
COPY ./sqli /app/sqli
COPY ./config /app/config