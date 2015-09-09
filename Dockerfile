FROM java:openjdk-7
MAINTAINER mkroli

ENV KARAF_VERSION=2.3.11
ENV KARAF_DEBUG true

RUN wget http://apache.openmirror.de/karaf/${KARAF_VERSION}/apache-karaf-${KARAF_VERSION}.tar.gz; \
    mkdir /opt/karaf; \
    tar --strip-components=1 -C /opt/karaf -xzf apache-karaf-${KARAF_VERSION}.tar.gz; \
    rm apache-karaf-${KARAF_VERSION}.tar.gz; \
    mkdir /deploy; \
    sed -i 's/^\(felix\.fileinstall\.dir\s*=\s*\).*$/\1\/deploy/' /opt/karaf/etc/org.apache.felix.fileinstall-deploy.cfg

ENV JAVA_VERSION=7u79

RUN wget --no-check-certificate --no-cookies \
    --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}-b15/jre-${JAVA_VERSION}-macosx-x64.tar.gz -O /deploy/jre.tar.gz && \
    mkdir /deploy/jre && \
    tar xzf /deploy/jre.tar.gz -C /deploy/jre

RUN wget http://apache.openmirror.de/karaf/${KARAF_VERSION}/apache-karaf-${KARAF_VERSION}.tar.gz -O /deploy/karaf.tar.gz && \
    mkdir /deploy/karaf && \
    tar xzf /deploy/karaf.tar.gz -C /deploy/karaf

VOLUME ["/deploy"]
EXPOSE 1099 8101 44444 5005

CMD ["./opt/karaf/bin/karaf"]
