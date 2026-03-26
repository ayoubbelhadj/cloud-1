FROM debian:bullseye

RUN apt update && apt install -y mariadb-server

COPY tools/script.sh .

EXPOSE 3306

CMD ["bash", "script.sh"]
