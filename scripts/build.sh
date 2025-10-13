#!/bin/bash

echo "=== Build e Deploy Azure Function JuntosColaborar ==="

# Verificar se está no diretório correto
if [ ! -f "src/JuntosColaborar.csproj" ]; then
    echo "Erro: Execute este script no diretório raiz do projeto"
    exit 1
fi

# Função para mostrar o menu
show_menu() {
    echo ""
    echo "Escolha uma opção:"
    echo "1) Restaurar dependências"
    echo "2) Build do projeto"
    echo "3) Executar localmente"
    echo "4) Build da imagem Docker"
    echo "5) Deploy no Minikube"
    echo "6) Ver logs do Kubernetes"
    echo "7) Limpar recursos do Kubernetes"
    echo "0) Sair"
    echo ""
}

# Loop principal
while true; do
    show_menu
    read -p "Digite sua opção: " choice
    
    case $choice in
        1)
            echo "Restaurando dependências..."
            dotnet restore
            ;;
        2)
            echo "Fazendo build do projeto..."
            dotnet build
            ;;
        3)
            echo "Executando localmente..."
            echo "Certifique-se de que o RabbitMQ está rodando!"
            func start --port 7072
            ;;
        4)
            echo "Fazendo build da imagem Docker..."
            docker build -t juntos-colaborar-function:latest .
            echo "Carregando imagem no Minikube..."
            minikube image load juntos-colaborar-function:latest
            ;;
        5)
            echo "Fazendo deploy no Minikube..."
            kubectl apply -f .k8s/k8s-deployment-local.yaml
            echo "Aguardando pods ficarem prontos..."
            kubectl wait --for=condition=ready pod -l app=juntos-colaborar-function --timeout=60s
            kubectl get pods -l app=juntos-colaborar-function
            ;;
        6)
            echo "Mostrando logs..."
            kubectl logs -l app=juntos-colaborar-function -f
            ;;
        7)
            echo "Removendo recursos do Kubernetes..."
            kubectl delete -f .k8s/k8s-deployment-local.yaml
            ;;
        0)
            echo "Saindo..."
            break
            ;;
        *)
            echo "Opção inválida. Tente novamente."
            ;;
    esac
done