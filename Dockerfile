FROM python:3.11.11-bullseye

WORKDIR /app

RUN apt-get update && apt-get install -y \
    python3-pip \
    python3-dev \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3-setuptools \
    python3-venv \
    && apt-get clean

RUN apt-get install curl gnupg2 ca-certificates lsb-release debian-archive-keyring -y && \
    curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor && \
    tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null && \
    echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] && \
    http://nginx.org/packages/debian `lsb_release -cs` nginx" && \
    tee /etc/apt/sources.list.d/nginx.list && \
    apt-get update -y && \
    apt-get install nginx -y

COPY requirements.txt .

RUN python -m venv .dev && \
    /bin/bash -c "source .dev/bin/activate && pip install --upgrade pip && pip install -r requirements.txt"

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

WORKDIR /etc/nginx

RUN mv nginx.conf nginx.conf.bak

WORKDIR /app/production

RUN mv nginx.conf /etc/nginx/ && \
    mv gunicorn_config.py .. && \
    mv gunicorn.service /etc/systemd/system/gunicorn.service

WORKDIR /app

EXPOSE 80

CMD ["sh", "-c", "service nginx start && gunicorn --config gunicorn_config.py blog.wsgi:application"]