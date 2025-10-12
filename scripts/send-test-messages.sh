#!/bin/bash

# Script para enviar mensagens de teste para o RabbitMQ
echo "=== Enviando mensagens de teste para RabbitMQ ==="

# Verificar se o RabbitMQ está acessível
if ! curl -s -u guest:guest http://rabbitmq.local/api/overview > /dev/null; then
    echo "❌ Erro: RabbitMQ não está acessível em rabbitmq.local"
    echo "   Verifique se o RabbitMQ está rodando"
    exit 1
fi

echo "✅ RabbitMQ acessível, enviando mensagens..."

# Mensagem 1
echo "Enviando mensagem 1..."
curl -s -u guest:guest -H "content-type:application/json" -X POST \
  -d '{"properties":{},"routing_key":"dev.demo.juntos.colaborar","payload":"{\"id\": 1, \"message\": \"Mensagem de teste 1\", \"timestamp\": \"'$(date -Iseconds)'\"}","payload_encoding":"string"}' \
  http://rabbitmq.local/api/exchanges/%2F/amq.default/publish

# Mensagem 2
echo "Enviando mensagem 2..."
curl -s -u guest:guest -H "content-type:application/json" -X POST \
  -d '{"properties":{},"routing_key":"dev.demo.juntos.colaborar","payload":"{\"id\": 2, \"message\": \"Mensagem de teste 2\", \"usuario\": \"'$USER'\", \"timestamp\": \"'$(date -Iseconds)'\"}","payload_encoding":"string"}' \
  http://rabbitmq.local/api/exchanges/%2F/amq.default/publish

# Mensagem 3
echo "Enviando mensagem 3..."
curl -s -u guest:guest -H "content-type:application/json" -X POST \
  -d '{"properties":{},"routing_key":"dev.demo.juntos.colaborar","payload":"{\"id\": 3, \"message\": \"Mensagem de teste 3\", \"status\": \"concluido\", \"timestamp\": \"'$(date -Iseconds)'\"}","payload_encoding":"string"}' \
  http://rabbitmq.local/api/exchanges/%2F/amq.default/publish

echo ""
echo "✅ 3 mensagens enviadas com sucesso!"
echo "Verifique os logs da Azure Function para confirmar o processamento."