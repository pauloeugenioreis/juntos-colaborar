#!/bin/bash

# Script para executar a Azure Function localmente
echo "=== Executando Azure Function JuntosColaborar ==="

# Verificar se está no diretório correto
if [ ! -f "src/JuntosColaborar.csproj" ]; then
    echo "Erro: Execute este script no diretório raiz do projeto"
    exit 1
fi

echo "Verificando se o RabbitMQ está acessível..."
if ! curl -s -u guest:guest http://rabbitmq.local/api/overview > /dev/null; then
    echo "⚠️  Aviso: RabbitMQ pode não estar acessível em rabbitmq.local"
    echo "   Verifique se o RabbitMQ está rodando e acessível"
fi

echo "Iniciando Azure Function na porta 7072..."
func start --port 7072