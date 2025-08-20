# Arquitetura de Observabilidade

Utilizando OpenTelemetry, Prometheus e Grafana para construção de uma arquitetura de Observabilidade para aplicações Spring Boot na AWS

### 📋 Pré-requisitos

- Conta AWS com permissões para ECS, EC2, CloudWatch, S3
- ECS com aplicações e EC2 para executar Docker Compose (Necessário Conectividade entre ECS e EC2)
- Docker e Docker Compose
- Aplicações Spring Boot instrumentadas com OpenTelemetry
- Configuração CloudWatch Logs c/ Data Firehose para envio dos Logs para o Loki na EC2 (No projeto foi utilizado Origem Direct PUT e Destino Endpoint HTTP)

### ⚙️ Executando 

```
docker-compose up
```

## Arquitetura do Projeto

Este projeto consistiu no planejamento e implementação de uma solução completa de monitoramento e observabilidade para aplicações Spring Boot executando em containers gerenciados pelo AWS Elastic Container Service (ECS).

O objetivo era garantir visibilidade completa sobre métricas, logs e traces, além de configurar canais de alerta para diferentes equipes operacionais, utilizando ferramentas modernas e escaláveis.

![Diagrama do projeto](assets/aws-bedrock-diagram.png)

### Desafios:

Unificar o rastreamento e observabilidade de múltiplas aplicações Spring Boot.
Coletar métricas de desempenho, logs e rastreamentos distribuídos com mínimo overhead.
Integrar diferentes ferramentas como Prometheus, Grafana, Loki, Tempo, CloudWatch e Firehose.
Garantir entregas em tempo real para canais como Teams e e-mail.
Escalabilidade e simplicidade na manutenção da stack de monitoramento.

### Solução Implementada:

#### Implementei uma stack de observabilidade dividida em três camadas principais:

#### Coleta:

As aplicações Spring Boot expõem métricas, logs e traces.
OpenTelemetry atua como agente unificador para rastreamento distribuído e os traces são armazenados no Grafana Tempo.
Prometheus coleta métricas de performance do JVM.
Logs são enviados via Cloudwatch e Data Firehose para o Grafana Alloy e por fim ao Grafana Loki.

#### Visualização e Análise:

Todas as informações são centralizadas no Grafana, com dashboards customizados.
Painéis específicos por serviço e por tipo de dado (métricas, logs e traces).
Visualização completa da jornada de requisições entre microserviços.

#### Alertas:

Alertas configurados no Grafana com integração direta para Microsoft Teams e e-mails corporativos, dependendo do time e criticidade do incidente.
