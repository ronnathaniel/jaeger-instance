#!/bin/bash

JAEGER_TAG=${JAEGER_TAG:-1.35}

# jaeger ui is at 16686

docker run \
  --rm \
  -it \
  --name jaeger \
  -e COLLECTOR_OTLP_ENABLED=true \
  -e COLLECTOR_ZIPKIN_HOST_PORT=:9411 \
  -e JAEGER_REPORTER_LOG_SPANS=true \
  -p 6831:6831/udp \
  -p 6832:6832/udp \
  -p 5775:5775/udp \
  -p 5778:5778 \
  -p 16686:16686 \
  -p 4317:4317 \
  -p 4318:4318 \
  -p 14250:14250 \
  -p 14268:14268 \
  -p 14269:14269 \
  -p 9411:9411 \
  jaegertracing/all-in-one:${JAEGER_TAG} \
  --log-level=debug



# -e SPAN_STORAGE_TYPE=elasticsearch \
# -e ES_SERVER_URLS=http://localhost:9200 \
# -e ES_SNIFFER=false \
