FROM prom/prometheus

MAINTAINER Kaija Chang <kaija.chang@gmail.com>

COPY templates/prometheus/prometheus.yaml /etc/prometheus/prometheus.yml
COPY templates/prometheus/alert.rules /etc/prometheus/alert.rules

