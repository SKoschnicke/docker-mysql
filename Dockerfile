FROM ubuntu:latest

ENV MYSQL_ROOT_PW rootpw
ENV MYSQL_USER mysql

RUN apt-get update

# mysql installation needs an mtab
RUN cat /proc/mounts > /etc/mtab

# set installation parameters to prevent the installation script from asking
RUN echo "mysql mysql-server/root_password string $MYSQL_ROOT_PW" | debconf-set-selections
RUN echo "mysql mysql-server/root_password_again string $MYSQL_ROOT_PW" | debconf-set-selections

RUN apt-get install -y mysql-server

# define database directory for start-script
ENV DATADIR /var/lib/mysql

# allow access from any IP
RUN sed -i '/^bind-address*/ s/127.0.0.1/0.0.0.0/' /etc/mysql/my.cnf
RUN mkdir -p $DATADIR
RUN sed -i "/^datadir*/ s|=.*|= $DATADIR|" /etc/mysql/my.cnf

# setup database directory as volume
VOLUME ["/var/lib/mysql"]

ADD start /
RUN chmod +x /start

EXPOSE 3306

CMD /start
