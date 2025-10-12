# Azure Function JuntosColaborar

Uma Azure Function .NET C# que consome mensagens da fila RabbitMQ `dev.demo.juntos.colaborar`.

## 🏗️ Estrutura do Projeto

```
.
├── src/                           # Código fonte
│   ├── JuntosColaborar.cs        # Função principal
│   └── Program.cs                # Configuração da aplicação
├── .k8s/                         # Arquivos Kubernetes
│   ├── Dockerfile               # Container Docker
│   └── k8s-deployment-local.yaml # Deployment local
├── scripts/                       # Scripts de automação
│   └── build.sh                 # Script de build e deploy
├── docs/                         # Documentação
│   ├── README.md                # Documentação detalhada
│   └── RABBITMQ_SETUP.md        # Setup do RabbitMQ
├── JuntosColaborar.csproj        # Arquivo do projeto .NET
├── host.json                     # Configuração do Functions Host
├── local.settings.json           # Configurações locais
└── .gitignore                    # Arquivos ignorados pelo Git
```

## 🚀 Quick Start

### Executar Localmente
```bash
./scripts/build.sh
# Escolha opção 3 (Executar localmente)
```

### Deploy no Kubernetes
```bash
./scripts/build.sh
# Escolha opção 4 (Build Docker) e depois opção 5 (Deploy K8s)
```

## 📚 Documentação

- **[Documentação Completa](docs/README.md)** - Guia detalhado de uso
- **[Setup RabbitMQ](docs/RABBITMQ_SETUP.md)** - Como configurar a fila RabbitMQ

## ⚙️ Configuração

### RabbitMQ
- **UI**: http://rabbitmq.local (guest/guest)
- **AMQP**: amqp://guest:guest@localhost:5672
- **Fila**: dev.demo.juntos.colaborar

### Características
- ✅ **Runtime**: .NET 8 (Isolated Process)
- ✅ **Sem Azure Storage**: Configurada para Kubernetes
- ✅ **RabbitMQ Trigger**: Consome mensagens automaticamente
- ✅ **Logging**: Logs detalhados para monitoramento

## 🛠️ Scripts Disponíveis

| Script | Descrição |
|--------|-----------|
| `./scripts/build.sh` | Menu interativo para build, run e deploy |

## 📋 Pré-requisitos

- .NET 8 SDK
- Azure Functions Core Tools
- Docker (para containerização)
- Kubernetes/Minikube (para deploy)
- RabbitMQ rodando e acessível