FROM debian:jessie

RUN (apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install wget)
RUN (wget --progress=dot --no-check-certificate -O /tmp/jdk-7u79-linux-x64.tar.gz --header "Cookie: oraclelicense=a" http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.tar.gz &&\
  echo "9222e097e624800fdd9bfb568169ccad  /tmp/jdk-7u79-linux-x64.tar.gz" | md5sum -c > /dev/null 2>&1 || (echo "ERROR: MD5SUM MISMATCH"; exit 1) &&\
  tar xzf /tmp/jdk-7u79-linux-x64.tar.gz &&\
  mkdir -p /usr/lib/jvm &&\
  mv jdk1.7.0_79 /usr/lib/jvm/ &&\
  mv /usr/lib/jvm/jdk1.7.0_79 /usr/lib/jvm/java-7-oracle &&\
  rm -rf jdk1.7.0_79 && rm /tmp/jdk-7u79-linux-x64.tar.gz &&\
  chown root:root -R /usr/lib/jvm/java-7-oracle)

RUN (update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-7-oracle/bin/java 1 &&\
  update-alternatives --set java /usr/lib/jvm/java-7-oracle/bin/java &&\
  update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/java-7-oracle/bin/javac 1 &&\
  update-alternatives --set javac /usr/lib/jvm/java-7-oracle/bin/javac &&\
  update-alternatives --install /usr/bin/javaws javaws /usr/lib/jvm/java-7-oracle/bin/javaws 1 &&\
  update-alternatives --set javaws /usr/lib/jvm/java-7-oracle/bin/javaws)
  
VOLUME ["/deploy"]
