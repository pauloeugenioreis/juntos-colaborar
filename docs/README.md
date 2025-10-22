# Azure Function JuntosColaborar

Esta é uma Azure Function .NET C# que consome mensagens da fila RabbitMQ `dev.demo.juntos.colaborar`.

## Características

- **Trigger**: RabbitMQTrigger
- **Fila**: dev.demo.juntos.colaborar
- **Runtime**: .NET 8 (Isolated Process)
- **Sem dependências do Azure Storage** - configurada para rodar no Kubernetes/Minikube

## Configuração do RabbitMQ

### Conexão
- **RabbitMQ UI**: http://rabbitmq.local (guest/guest)
- **RabbitMQ AMQP**: amqp://guest:guest@localhost:5672
- **Dashboard**: http://localhost:15671

### Criando a Fila no RabbitMQ UI

1. Acesse http://rabbitmq.local
2. Faça login com guest/guest
3. Vá para a aba "Queues"
4. Clique em "Add a new queue"
5. Configure:
   - **Name**: dev.demo.juntos.colaborar
   - **Durability**: Durable (recomendado)
   - **Auto delete**: No
   - Deixe os outros campos como padrão
6. Clique em "Add queue"

### Enviando Mensagens de Teste

1. Na lista de filas, clique em "dev.demo.juntos.colaborar"
2. Role para baixo até a seção "Publish message"
3. Configure:
   - **Payload**: Digite sua mensagem (ex: "Olá, JuntosColaborar!")
   - **Headers**: (opcional)
4. Clique em "Publish message"

## Executando Localmente

### Pré-requisitos
- .NET 8 SDK
- Azure Functions Core Tools
- RabbitMQ rodando (conforme suas configurações)

### Comandos

```bash
# Restaurar dependências
dotnet restore

# Executar localmente
func start
```

## Executando com Docker Compose

### Pré-requisitos
- Docker
- Docker Compose

### Comandos

```bash
# Executar aplicação e RabbitMQ
./scripts/run-docker-compose.sh

# Ou diretamente:
docker-compose up --build
```

### Acesso aos Serviços
- **Aplicação**: http://localhost:7072
- **RabbitMQ UI**: http://localhost:15672 (guest/guest)

### Funcionalidades
- RabbitMQ é iniciado automaticamente com a fila `dev.demo.juntos.colaborar` criada.
- A aplicação conecta-se ao RabbitMQ via Docker network.
- Dados do RabbitMQ são persistidos em um volume Docker.

### Parar os Serviços
```bash
docker-compose down
```

## Deploy no Kubernetes/Minikube

### Build da imagem Docker

```bash
# Build da imagem
docker build -t juntos-colaborar-function:latest .

# Para Minikube, carregue a imagem
minikube image load juntos-colaborar-function:latest
```

### Deploy no Kubernetes

```bash
# Aplicar o deployment
kubectl apply -f k8s-deployment.yaml

# Verificar o status
kubectl get pods
kubectl get services

# Ver logs
kubectl logs -l app=juntos-colaborar-function -f
```

## Estrutura do Projeto

```
.
├── src/                           # Código fonte
│   ├── JuntosColaborar.cs         # Função principal
│   ├── Program.cs                 # Configuração da aplicação
│   └── JuntosColaborar.csproj     # Arquivo do projeto .NET
├── .k8s/                          # Arquivos Kubernetes
│   ├── Dockerfile                 # Container Docker
│   └── k8s-deployment-local.yaml  # Deployment local
├── scripts/                       # Scripts de automação
│   └── build.sh                   # Script de build e deploy
├── docs/                          # Documentação
│   ├── README.md                  # Documentação detalhada
│   └── RABBITMQ_SETUP.md          # Setup do RabbitMQ
├── host.json                      # Configuração do Functions Host
├── local.settings.json            # Configurações locais
└── .gitignore                     # Arquivos ignorados pelo Git
```

## Funcionalidades

A função `JuntosColaborar`:
- Consome mensagens da fila `dev.demo.juntos.colaborar`
- Faz log das mensagens recebidas
- Processa as mensagens (você pode customizar a lógica no método `ProcessMessage`)
- Trata erros e re-lança exceções para que o RabbitMQ saiba sobre falhas

## Customização

Para adicionar sua lógica de negócio, edite o método `ProcessMessage` no arquivo `JuntosColaborar.cs`.

## Monitoramento

- Os logs aparecem no console da aplicação
- Use `kubectl logs` para ver os logs no Kubernetes
- As métricas podem ser visualizadas no RabbitMQ Management UI

## Importante

- Esta configuração **não utiliza Azure Storage**, sendo ideal para ambientes Kubernetes
- A conexão com RabbitMQ deve estar acessível do pod Kubernetes
- Ajuste a connection string no `k8s-deployment.yaml` conforme seu ambiente