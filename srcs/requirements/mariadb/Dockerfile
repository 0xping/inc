FROM debian:bullseye

RUN apt update && apt install mariadb-server -y

EXPOSE 3306

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/db.sh /bin/

RUN chmod +x /bin/db.sh

CMD ["db.sh"]