# Configurações para diferentes ambientes

## Local/Desenvolvimento
- **Arquivo**: `.k8s/k8s-deployment-local.yaml`
- **Replicas**: 1
- **Resources**: Básicos (256Mi memory, 250m CPU)
- **RabbitMQ**: amqp://guest:guest@rabbitmq.local:5672

## Desenvolvimento
- **Arquivo**: `.k8s/k8s-deployment-dev.yaml`
- **Replicas**: 1
- **Resources**: Básicos (256Mi memory, 250m CPU)
- **RabbitMQ**: amqp://guest:guest@rabbitmq.local:5672
- **Environment**: Development

## Produção
- **Arquivo**: `.k8s/k8s-deployment-prod.yaml`
- **Replicas**: 3 (alta disponibilidade)
- **Resources**: Elevados (512Mi memory, 500m CPU)
- **RabbitMQ**: Via Secret do Kubernetes
- **Environment**: Production
- **Health Checks**: Liveness e Readiness probes
- **Service**: LoadBalancer

## Deploy por ambiente

```bash
# Local/Minikube
kubectl apply -f .k8s/k8s-deployment-local.yaml

# Desenvolvimento
kubectl apply -f .k8s/k8s-deployment-dev.yaml

# Produção (após configurar o secret)
kubectl apply -f .k8s/k8s-deployment-prod.yaml
```

## Configuração do Secret para Produção

```bash
kubectl create secret generic rabbitmq-connection \
  --from-literal=connection-string="amqp://user:password@rabbitmq-prod.example.com:5672"
```