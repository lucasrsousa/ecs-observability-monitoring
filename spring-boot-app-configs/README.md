### Configurações no properties

#### ACTUATOR
management.server.port=APP_PORT
management.endpoint.metrics.enabled=true
management.endpoint.prometheus.enabled=true
management.endpoints.web.exposure.include=prometheus,metrics,health,info
management.metrics.export.prometheus.enabled=true
management.metrics.enable.jvm=true
management.metrics.tags.application=name-application

#### OpenTelemetry
otel.service.name=name-application
otel.exporter.otlp.endpoint=http://IP_OR_DOMAIN:4319
otel.exporter.otlp.protocol=grpc
otel.metrics.exporter=none
otel.logs.exporter=none
otel.traces.exporter=otlp

#### pom.xml

Dependencias usadas:

- micrometer-registry-prometheus
- opentelemetry-exporter-otlp
- opentelemetry-spring-boot-starter
- opentelemetry-jdbc
- opentelemetry-logback-mdc-1.0
