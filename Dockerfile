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

EXPOSE 80

#Start apache in background

ENTRYPOINT ["/usr/sbin/httpd", "-D", "FOREGROUND"]
