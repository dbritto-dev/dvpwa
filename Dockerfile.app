FROM python:3.9-slim-buster as builder
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
WORKDIR /app
RUN apt-get update -y && apt-get install -y libpq-dev
COPY requirements.txt ./
RUN python -m pip install --upgrade pip && python -m pip install -U -r requirements.txt && rm requirements.txt

FROM python:3.9-slim-buster
WORKDIR /app
COPY --from=builder /root/.local /root/.local
COPY . .
ENV PATH=/root/.local:$PATH
EXPOSE 8080
CMD ["python", "run.py"]

WORKDIR /app
COPY ./run.py /app
COPY ./sqli /app/sqli
COPY ./config /app/config
