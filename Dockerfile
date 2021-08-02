FROM centos:latest

ENV DEBIAN_FRONTEND noninteractive
ENV SCALA_VERSION 2.12
ENV KAFKA_VERSION 2.8.0
ENV ZOOKEEPER_VERSION 3.7.0
ENV KAFKA_HOME /opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"


RUN dnf update -y
RUN dnf install epel-release -y
RUN dnf install java wget vim -y

#### Kafka Downloading & Install
#RUN wget https://downloads.apache.org/kafka/"$KAFKA_VERSION"/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz -O /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz
#RUN tar xfz /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz -C /opt && \
#    rm /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz

#### Zookeeper Downloading & Install
RUN wget https://downloads.apache.org/zookeeper/zookeeper-$ZOOKEEPER_VERSION/apache-zookeeper-$ZOOKEEPER_VERSION-bin.tar.gz  -O  /tmp/apache-zookeeper-$ZOOKEEPER_VERSION-bin.tar.gz
RUN tar xfz /tmp/apache-zookeeper-$ZOOKEEPER_VERSION-bin.tar.gz -C /opt && \
    rm /tmp/apache-zookeeper-$ZOOKEEPER_VERSION-bin.tar.gz && \
    mv /opt/apache-zookeeper-$ZOOKEEPER_VERSION-bin /opt/zookeeper-$ZOOKEEPER_VERSION  && \
    mv /opt/zookeeper-$ZOOKEEPER_VERSION/conf/zoo_sample.cfg  /opt/zookeeper-$ZOOKEEPER_VERSION/conf/zoo.cfg

RUN yum -y install  telnet net-tools

RUN ls -l /opt/zookeeper-3.7.0/bin/
RUN java -version

EXPOSE 2181

ENTRYPOINT ["/opt/zookeeper-3.7.0/bin/zkServer.sh"]
CMD ["start-foreground"]
