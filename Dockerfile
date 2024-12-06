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

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]