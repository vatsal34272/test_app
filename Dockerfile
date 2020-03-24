#Baseimage-Information

FROM docker.io/centos

#Maintainer Information

MAINTAINER Vatsal Thakor

#Install required rpm's

RUN yum install vim net-tools httpd iproute php -y

#Copy source code (index.html)

COPY . /var/www/html/

#Provide necessary permission 

RUN chmod 644 /var/www/html/index.html

#Expose port on which application listen

EXPOSE 8080

LABEL io.openshift.expose-services="8080:http"

#Change the port number in the Apache HTTP Server configuration file

RUN sed -i "s/Listen 80/Listen 8080/g" /etc/httpd/conf/httpd.conf

#Change the group ID and permissions

RUN chgrp -R 0 /var/log/httpd /var/run/httpd && \
chmod -R g=u /var/log/httpd /var/run/httpd

#Add a USER instruction for an unprivileged user.

USER 1001

#Start apache in background

ENTRYPOINT ["/usr/sbin/httpd", "-D", "FOREGROUND"]
