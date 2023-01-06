#!/bin/bash

JAEGER_TAG=${JAEGER_TAG:-1.35}

# jaeger ui is at 16686

docker run --rm -it --name jaeger \
  -e COLLECTOR_ZIPKIN_HOST_PORT=:9411 \
  -e SPAN_STORAGE_TYPE=elasticsearch \
  -e ES_SERVER_URLS=http://localhost:9200 \
  -p 5775:5775/udp \
  -p 6831:6831/udp \
  -p 6832:6832/udp \
  -p 5778:5778 \
  -p 16686:16686 \
  -p 14268:14268 \
  -p 14250:14250 \
  -p 9411:9411 \
  jaegertracing/all-in-one:${JAEGER_TAG}
