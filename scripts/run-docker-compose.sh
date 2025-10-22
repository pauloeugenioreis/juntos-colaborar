#!/bin/bash

# Script para executar a aplicação e RabbitMQ usando Docker Compose
echo "=== Executando JuntosColaborar com Docker Compose ==="

# Verificar se está no diretório correto
if [ ! -f "docker-compose.yml" ]; then
    echo "Erro: Execute este script no diretório raiz do projeto (onde está o docker-compose.yml)"
    exit 1
fi

# Verificar se Docker está instalado
if ! command -v docker &> /dev/null; then
    echo "Erro: Docker não está instalado. Instale o Docker primeiro."
    exit 1
fi

# Verificar se Docker Compose está instalado
if ! command -v docker-compose &> /dev/null; then
    echo "Erro: Docker Compose não está instalado. Instale o Docker Compose primeiro."
    exit 1
fi

echo "Construindo e iniciando os serviços (RabbitMQ + Aplicação)..."
echo "RabbitMQ UI: http://localhost:15672 (guest/guest)"
echo "Aplicação: http://localhost:7072"
echo ""
echo "Para parar: pressione Ctrl+C ou execute 'docker-compose down' em outro terminal"
echo ""

docker-compose up --build