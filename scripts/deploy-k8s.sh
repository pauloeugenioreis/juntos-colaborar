#!/bin/bash

# Script para fazer deploy no Kubernetes
echo "=== Deploy Azure Function no Kubernetes ==="

# Verificar se está no diretório correto
if [ ! -f "JuntosColaborar.csproj" ]; then
    echo "Erro: Execute este script no diretório raiz do projeto"
    exit 1
fi

echo "1. Fazendo build da imagem Docker..."
docker build -f .k8s/Dockerfile -t juntos-colaborar-function:latest .

if [ $? -ne 0 ]; then
    echo "❌ Erro no build da imagem Docker"
    exit 1
fi

echo "2. Carregando imagem no Minikube..."
minikube image load juntos-colaborar-function:latest

if [ $? -ne 0 ]; then
    echo "❌ Erro ao carregar imagem no Minikube"
    exit 1
fi

echo "3. Aplicando deployment no Kubernetes..."
kubectl apply -f .k8s/k8s-deployment-local.yaml

if [ $? -ne 0 ]; then
    echo "❌ Erro no deployment Kubernetes"
    exit 1
fi

echo "4. Aguardando pods ficarem prontos..."
kubectl wait --for=condition=ready pod -l app=juntos-colaborar-function --timeout=60s

echo "5. Status dos pods:"
kubectl get pods -l app=juntos-colaborar-function

echo ""
echo "✅ Deploy concluído!"
echo "Para ver os logs: kubectl logs -l app=juntos-colaborar-function -f"