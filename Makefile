all: image

image:
	echo "nothing"

stop_all: stop_prometheus stop_alertmanager stop_pushgateway

pushgateway:
	docker run -d -p 9091:9091 --name pushgateway prom/pushgateway

stop_pushgateway:
	docker stop pushgateway
	docker rm pushgateway

alertmanager:
	docker run -d -p 9093:9093 -v ${PWD}/templates/alertmanager/alertmanager.yml:/alertmanager.yml --name alertmanager prom/alertmanager -config.file=/alertmanager.yml

debug_alertmanager:
	docker run -p 9093:9093 -v ${PWD}/templates/alertmanager/alertmanager.yml:/alertmanager.yml --name alertmanager prom/alertmanager -config.file=/alertmanager.yml

stop_alertmanager:
	docker stop alertmanager
	docker rm alertmanager

prometheus:
	docker run -d -p 9090:9090 -v ${PWD}/templates/prometheus/prometheus.yaml:/etc/prometheus/prometheus.yml \
-v ${PWD}/templates/prometheus/alert.rules:/etc/prometheus/alert.rules \
--name prometheus \
prom/prometheus \
-config.file=/etc/prometheus/prometheus.yml \
-alertmanager.url=http://10.211.55.43:9093

debug_prometheus:
	docker run -p 9090:9090 -v ${PWD}/templates/prometheus/prometheus.yaml:/etc/prometheus/prometheus.yml \
-v ${PWD}/templates/prometheus/alert.rules:/etc/prometheus/alert.rules \
--name prometheus \
prom/prometheus \
-config.file=/etc/prometheus/prometheus.yml \
-alertmanager.url=http://10.211.55.43:9093

stop_prometheus:
	docker stop prometheus
	docker rm prometheus
