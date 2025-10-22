#!/bin/bash

# Script para enviar mensagens de teste para o RabbitMQ
echo "=== Enviando mensagens de teste para RabbitMQ ==="

# Função para verificar e definir o host do RabbitMQ
check_rabbitmq() {
    if curl -s -u guest:guest http://rabbitmq.local/api/overview > /dev/null 2>&1; then
        RABBITMQ_HOST="rabbitmq.local"
        echo "✅ RabbitMQ encontrado em rabbitmq.local"
        return 0
    elif curl -s -u guest:guest http://localhost:15672/api/overview > /dev/null 2>&1; then
        RABBITMQ_HOST="localhost:15672"
        echo "✅ RabbitMQ encontrado em localhost:15672 (Docker Compose)"
        return 0
    else
        echo "❌ Erro: RabbitMQ não está acessível em rabbitmq.local nem em localhost:15672"
        echo "   Verifique se o RabbitMQ está rodando localmente ou via Docker Compose"
        return 1
    fi
}

# Verificar se o RabbitMQ está acessível
if ! check_rabbitmq; then
    exit 1
fi

echo "Enviando mensagens..."

# Mensagem 1
echo "Enviando mensagem 1..."
curl -s -u guest:guest -H "content-type:application/json" -X POST \
  -d '{"properties":{},"routing_key":"dev.demo.juntos.colaborar","payload":"{\"id\": 1, \"message\": \"Mensagem de teste 1\", \"timestamp\": \"'$(date -Iseconds)'\"}","payload_encoding":"string"}' \
  http://$RABBITMQ_HOST/api/exchanges/%2F/amq.default/publish

# Mensagem 2
echo "Enviando mensagem 2..."
curl -s -u guest:guest -H "content-type:application/json" -X POST \
  -d '{"properties":{},"routing_key":"dev.demo.juntos.colaborar","payload":"{\"id\": 2, \"message\": \"Mensagem de teste 2\", \"usuario\": \"'$USER'\", \"timestamp\": \"'$(date -Iseconds)'\"}","payload_encoding":"string"}' \
  http://$RABBITMQ_HOST/api/exchanges/%2F/amq.default/publish

# Mensagem 3
echo "Enviando mensagem 3..."
curl -s -u guest:guest -H "content-type:application/json" -X POST \
  -d '{"properties":{},"routing_key":"dev.demo.juntos.colaborar","payload":"{\"id\": 3, \"message\": \"Mensagem de teste 3\", \"status\": \"concluido\", \"timestamp\": \"'$(date -Iseconds)'\"}","payload_encoding":"string"}' \
  http://$RABBITMQ_HOST/api/exchanges/%2F/amq.default/publish

echo ""
echo "✅ 3 mensagens enviadas com sucesso!"
echo "Verifique os logs da Azure Function para confirmar o processamento."