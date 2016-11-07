FROM java:alpine
MAINTAINER Gianluca Tomasino <gianluca.tomasino@jobrapido.com>

ENV SBT_VERSION 0.13.11
ENV SBT_HOME /usr/local/sbt
ENV PATH ${PATH}:${SBT_HOME}/bin

RUN apk add --update curl bash && \
    rm -rf /var/cache/apk/*

RUN mkdir -p /usr/local/sbin/

RUN curl -sL -o /usr/local/sbin/sbt-launch.jar https://repo.typesafe.com/typesafe/ivy-releases/org.scala-sbt/sbt-launch/$SBT_VERSION/sbt-launch.jar

COPY script/sbt /usr/local/sbin/sbt
RUN chmod u+x /usr/local/sbin/sbt

RUN sbt sbtVersion

VOLUME ["/app"]
WORKDIR /app

ENTRYPOINT ["sbt"]
