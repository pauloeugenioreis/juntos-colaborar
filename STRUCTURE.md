# 📁 Estrutura Organizada do Projeto

## ✅ **Estrutura Final**

```
JuntosColaborar/
├── 📁 src/                                   # Código fonte
│   ├── JuntosColaborar.cs                    # Função principal com RabbitMQTrigger
│   ├── Program.cs                            # Configuração da aplicação
│   └── JuntosColaborar.csproj                # Arquivo do projeto .NET
│
├── 📁 .k8s/                                  # Arquivos Kubernetes
│   ├── Dockerfile                            # Container Docker
│   ├── k8s-deployment-local.yaml             # Deploy para Minikube/Local
│   ├── k8s-deployment-dev.yaml               # Deploy para Desenvolvimento
│   ├── k8s-deployment-prod.yaml              # Deploy para Produção
│   └── ENVIRONMENTS.md                       # Documentação dos ambientes
│
├── 📁 scripts/                               # Scripts de automação
│   ├── build.sh                              # Menu interativo completo
│   ├── run-local.sh                          # Executar localmente
│   ├── deploy-k8s.sh                         # Deploy automatizado no K8s
│   └── send-test-messages.sh                 # Enviar mensagens de teste
│
├── 📁 docs/                                  # Documentação
│   ├── README.md                             # Documentação detalhada
│   └── RABBITMQ_SETUP.md                     # Setup do RabbitMQ
│
├── 📄 host.json                              # Configuração do Functions Host
├── 📄 local.settings.json                    # Configurações locais
├── 📄 local.settings.example.json            # Exemplo de configurações
├── 📄 .gitignore                             # Arquivos ignorados pelo Git
└── 📄 README.md                              # Documentação principal
```

## 🚀 **Comandos Disponíveis**

### **Scripts Principais**
```bash
# Menu interativo completo
./scripts/build.sh

# Executar localmente
./scripts/run-local.sh

# Deploy no Kubernetes
./scripts/deploy-k8s.sh

# Enviar mensagens de teste
./scripts/send-test-messages.sh
```

### **Deploy por Ambiente**
```bash
# Local/Minikube
kubectl apply -f .k8s/k8s-deployment-local.yaml

# Desenvolvimento  
kubectl apply -f .k8s/k8s-deployment-dev.yaml

# Produção
kubectl apply -f .k8s/k8s-deployment-prod.yaml
```

### **Comandos .NET**
```bash
# Build
dotnet build

# Restaurar dependências
dotnet restore

# Executar localmente
func start --port 7072
```

## 📋 **Organização por Tipo de Arquivo**

| Extensão | Localização | Propósito |
|----------|-------------|-----------|
| **.cs** | `src/` | Código fonte C# |
| **.yaml/.yml** | `.k8s/` | Manifestos Kubernetes |
| **.sh** | `scripts/` | Scripts de automação |
| **.md** | `docs/` e raiz | Documentação |
| **.json** | Raiz | Configurações |
| **Dockerfile** | `.k8s/` | Containerização |

## 🎯 **Benefícios da Organização**

- ✅ **Separação clara** entre código, deploy e documentação
- ✅ **Scripts organizados** por funcionalidade
- ✅ **Deploy multi-ambiente** (local, dev, prod)
- ✅ **Documentação centralizada** em `docs/`
- ✅ **Automação completa** via scripts
- ✅ **Padrões de mercado** seguidos
- ✅ **Fácil manutenção** e colaboração

## 🔄 **Workflow Típico**

1. **Desenvolvimento**: Editar código em `src/`
2. **Teste Local**: `./scripts/run-local.sh`
3. **Build**: `./scripts/build.sh` → opção 2
4. **Deploy**: `./scripts/deploy-k8s.sh`
5. **Teste**: `./scripts/send-test-messages.sh`
6. **Monitoramento**: `kubectl logs -l app=juntos-colaborar-function -f`