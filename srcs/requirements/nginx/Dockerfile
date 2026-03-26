FROM debian:bullseye

RUN apt-get update -y && apt-get install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx-selfsigned.key \
    -out /etc/nginx/ssl/nginx-selfsigned.crt \
    -subj "/C=US/ST=State/L=City/O=Organization/CN=localhost"

COPY conf/default /etc/nginx/sites-available/default

RUN mkdir -p /run/nginx

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
