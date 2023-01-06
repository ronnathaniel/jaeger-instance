
import os
import sys
import requests
from time import sleep
import subprocess
import asyncio
import random

from opentelemetry import trace
from opentelemetry.exporter.jaeger.thrift import JaegerExporter
# from opentelemetry.exporter.jaeger.proto.grpc import JaegerExporter

from opentelemetry.sdk.resources import SERVICE_NAME, Resource
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import (
    BatchSpanProcessor,
    ConsoleSpanExporter,
)

ms_asleep = 50e-3


def wrap_span(decorators):
    def decorate(func):
        for d in decorators[::-1]:
            func = d(func)
        return func
    return decorate


if __name__ == '__main__':

    endpoint = sys.argv[1]
    resource = Resource(attributes={
        SERVICE_NAME: "MyServiceName"
    })
    jaeger_exporter = JaegerExporter(
        agent_host_name=endpoint,
        agent_port=6831,
    )
    provider = TracerProvider(resource=resource)
    processor = BatchSpanProcessor(
        jaeger_exporter,
        max_queue_size=60,
        max_export_batch_size=6,
    )
    provider.add_span_processor(processor)
    trace.set_tracer_provider(provider)
    tracer = trace.get_tracer(__name__)

    # Instrumented Function
    create_trace = lambda: None

    instrumented_func = wrap_span([
        tracer.start_as_current_span('MySpan-' + str(i))
        for i in range(3)
    ])(create_trace)

    for i in range(100000):
        instrumented_func()
        if i and not i % 100:
            print(i, 'Sent')
