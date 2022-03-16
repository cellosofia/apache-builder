# Esto es un comentario
FROM registry.access.redhat.com/ubi7/ubi:7.7

LABEL description="My Apache Image" \
      io.k8s.description="My Apache Image" \
      io.openshift.expose-services="8080:tcp" \
      io.openshift.s2i.scripts-url="image:///usr/libexec/s2i"

MAINTAINER Pablo Peralta <cellosofia1@gmail.com>

WORKDIR /var/www/html

RUN yum -y install httpd && \
    yum clean all && \
    sed -i 's/Listen 80/Listen 8080/g' /etc/httpd/conf/httpd.conf && \
    chgrp -R 0 /var/log/httpd /var/run/httpd /var/www/html && \
    chmod -R g=u /var/log/httpd /var/run/httpd /var/www/html && \
    chmod g+s /var/www/html

EXPOSE 8080

ENV LogLevel "info" \
    MyEnv "anothervar"

COPY ./s2i/bin/ /usr/libexec/s2i

USER 1001

CMD ["/usr/libexec/s2i/usage"]
