FROM java:8
MAINTAINER Amol

# 'snapshot' or 'release'
ENV XD_BUILD snapshot
ENV XD_VERSION 1.2.0.BUILD-SNAPSHOT

RUN groupadd -r springxd && useradd -r -g springxd springxd

RUN wget http://repo.spring.io/${XD_BUILD}/org/springframework/xd/spring-xd/${XD_VERSION}/spring-xd-${XD_VERSION}-dist.zip \
      -O /opt/spring-xd-${XD_VERSION}-dist.zip \
    && unzip /opt/spring-xd-${XD_VERSION}-dist.zip -d /opt/ \
    && rm /opt/spring-xd-${XD_VERSION}-dist.zip \
    && apt-get update && apt-get install -y rsync build-essential \
    && /opt/spring-xd-${XD_VERSION}/zookeeper/bin/install-zookeeper \
    && /opt/spring-xd-${XD_VERSION}/redis/bin/install-redis \
    && apt-get remove -y rsync build-essential \
    && chown -R springxd:springxd /opt/spring-xd-${XD_VERSION} \
    && ln -s /opt/spring-xd-${XD_VERSION} /opt/spring-xd

USER springxd
WORKDIR /opt/spring-xd
