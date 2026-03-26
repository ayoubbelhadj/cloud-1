FROM debian:bookworm

RUN apt-get update && apt-get install -y curl

RUN apt-get install -y php php-mysql php-fpm

RUN sed -i 's#listen = /run/php/php8.2-fpm.sock#listen = 9000#' /etc/php/8.2/fpm/pool.d/www.conf

COPY tools/script.sh .

CMD ["bash", "./script.sh"]
