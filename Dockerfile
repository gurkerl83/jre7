FROM busybox
MAINTAINER gurkerl83

ENV JAVA_VERSION=7u79
ENV KARAF_VERSION=2.3.11

ENV KARAF_DEBUG true
EXPOSE 1099 8101 44444 5005

#RUN wget http://apache.openmirror.de/karaf/${KARAF_VERSION}/apache-karaf-${KARAF_VERSION}.tar.gz; \
#    mkdir /opt/karaf; \
#    tar --strip-components=1 -C /opt/karaf -xzf apache-karaf-${KARAF_VERSION}.tar.gz; \
#    rm apache-karaf-${KARAF_VERSION}.tar.gz; \
#    mkdir /deploy; \
#    sed -i 's/^\(felix\.fileinstall\.dir\s*=\s*\).*$/\1\/deploy/' /opt/karaf/etc/org.apache.felix.fileinstall-deploy.cfg

RUN mkdir /tmp && \
    mkdir /deploy

RUN wget --no-check-certificate --no-cookies \
    --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}-b15/jre-${JAVA_VERSION}-macosx-x64.tar.gz -O /tmp/jre.tar.gz && \
    mkdir /tmp/jre && \
    tar xzf /tmp/jre.tar.gz -C /tmp/jre

RUN wget http://apache.openmirror.de/karaf/${KARAF_VERSION}/apache-karaf-${KARAF_VERSION}.tar.gz -O /tmp/karaf.tar.gz && \
    mkdir /tmp/karaf && \
    tar xzf /tmp/karaf.tar.gz -C /tmp/karaf

VOLUME ["/deploy"]

COPY /tmp /deploy

#CMD ["./opt/karaf/bin/karaf"]
CMD /bin/sh
