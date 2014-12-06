FROM java:openjdk-6-jre
MAINTAINER Michał Fa < mf@laboratorium.ee >

ENV VERSION 14.3.0-1186


RUN apt-get update && \
         apt-get -y install python-software-properties unzip subversion git procps

RUN wget http://download.go.cd/gocd-deb/go-server-$VERSION.deb -O /go-server.deb && \
         wget http://download.go.cd/gocd-deb/go-agent-$VERSION.deb -O /go-agent.deb  &&\
         dpkg -i /go-server.deb &&\
         dpkg -i /go-agent.deb  &&\
         rm -f ./*.deb 


EXPOSE 8153

ENTRYPOINT  ["/bin/bash", "-c", "/etc/init.d/go-server start && /etc/init.d/go-agent start && \
        tail -f /var/log/go-agent/go-agent*.log /var/log/go-server/go-*.log"]
 