#!/bin/bash

set -e

REGION="us-east-1"
CLUSTER="ecs-cluster" # Cluster name
TARGET_DIR="/etc/prometheus/targets"  # Onde o Prometheus lê os arquivos
PORT=8888 # Porta do serviço
SERVICES=("app-prometheus-task-service") # nome dos serviços

mkdir -p "$TARGET_DIR"

for SERVICE in "${SERVICES[@]}"; do
  echo "Atualizando targets para serviço: $SERVICE"

  TASK_ARNs=$(aws ecs list-tasks \
    --cluster "$CLUSTER" \
    --service-name "$SERVICE" \
    --region "$REGION" \
    --query "taskArns[]" \
    --output text)

  [[ -z "$TASK_ARNs" ]] && {
    echo "Nenhuma task encontrada para $SERVICE"
    echo "[]" > "$TARGET_DIR/$SERVICE.json"
    continue
  }

  TASK_DETAILS=$(aws ecs describe-tasks \
    --cluster "$CLUSTER" \
    --tasks $TASK_ARNs \
    --region "$REGION")

  ENI_IDs=$(echo "$TASK_DETAILS" | jq -r '.tasks[].attachments[].details[] | select(.name == "networkInterfaceId") | .value')

  TARGETS=()

  for ENI in $ENI_IDs; do
    IP=$(aws ec2 describe-network-interfaces \
      --network-interface-ids "$ENI" \
      --region "$REGION" \
      --query "NetworkInterfaces[0].PrivateIpAddress" \
      --output text)

    TARGETS+=("{\"targets\": [\"$IP:$PORT\"]}")
  done

  JSON_OUTPUT=$(echo "${TARGETS[@]}" | jq -s '.')

  echo "$JSON_OUTPUT" > "$TARGET_DIR/$SERVICE.json"

  echo "Arquivo gerado: $TARGET_DIR/$SERVICE.json"
done
