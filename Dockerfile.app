FROM python:3.9-slim-buster as builder
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
WORKDIR /app
COPY requirements.txt ./
RUN python -m pip install --upgrade pip && python -m pip install -U -r requirements.txt
RUN rm requirements.txt

FROM python:3.9-slim-buster
WORKDIR /app
COPY --from=builder /root/.local /root/.local
COPY . .
ENV PATH=/root/.local:$PATH
EXPOSE 8080
CMD ["python", "run.py"]

WORKDIR /app
ADD ./run.py /app
ADD ./sqli /app/sqli
ADD ./config /app/config
