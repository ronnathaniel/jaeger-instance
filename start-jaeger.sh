#!/bin/bash

JAEGER_TAG=${JAEGER_TAG:-1.41}

# jaeger ui is at 16686

docker run \
  --rm \
  -it \
  --name jaeger \
  -e COLLECTOR_OTLP_ENABLED=true \
  -e JAEGER_REPORTER_LOG_SPANS=true \
  -p 6831:6831/udp \
  -p 6832:6832/udp \
  -p 16685:16685 \
  -p 16686:16686 \
  -p 4317:4317 \
  -p 4318:4318 \
  -p 14268:14268 \
  -p 9411:9411 \
  jaegertracing/all-in-one:${JAEGER_TAG} \
  --log-level=debug



# -e SPAN_STORAGE_TYPE=elasticsearch \
# -e ES_SERVER_URLS=http://localhost:9200 \
# -e ES_SNIFFER=false \
