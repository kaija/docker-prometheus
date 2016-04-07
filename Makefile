all: image

image:
	echo "nothing"

pushgateway:
	docker run -d -p 9091:9091 prom/pushgateway

alertmanager:
	docker run -p 9093:9093 -v ${PWD}/templates/alertmanager/alertmanager.yml:/alertmanager.yml prom/alertmanager -config.file=/alertmanager.yml

prometheus:
	docker run -p 9090:9090 -v ${PWD}/templates/prometheus/prometheus.yaml:/etc/prometheus/prometheus.yml \
-v ${PWD}/templates/prometheus/alert.rules:/etc/prometheus/alert.rules \
prom/prometheus \
-config.file=/etc/prometheus/prometheus.yml \
-alertmanager.url=http://10.211.55.43:9093
