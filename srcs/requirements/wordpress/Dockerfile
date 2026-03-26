FROM debian:bullseye

RUN apt-get update && apt-get install -y curl

RUN apt-get install -y php php-mysql php-fpm php-redis

RUN sed -i 's#listen = /run/php/php7.4-fpm.sock#listen = 9000#' /etc/php/7.4/fpm/pool.d/www.conf

COPY tools/script.sh .

CMD ["bash", "./script.sh"]
