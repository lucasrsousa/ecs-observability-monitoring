### Atualizando os serviços no Prometheus via Shell

Como os containers do ECS não são persistentes, eles podem ser destruídos e recriados ao longo do dia, fazendo com que seus IPs privados mudem constantemente.

O update-prometheus-targets.sh é um script em Shell desenvolvido para ser executado periodicamente via Cron no servidor que roda o Docker Compose. Ele atualiza a lista de serviços ativos do ECS, garantindo que o Prometheus sempre receba os endpoints corretos para monitoramento.

Lembrando que a EC2 precisaria ter permissões minimas para coletar informações dos Containers