FROM logstash:latest
RUN apt-get update && \
    apt-get install -y cifs-utils && \
    apt-get clean all

COPY assets/docker-entrypoint.sh /docker-entrypoint.sh
