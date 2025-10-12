# 📝 Convenções de Nomenclatura

## ✅ **Por que `.k8s/` é melhor que `deploy/`?**

### 🎯 **Especificidade**
- **`.k8s/`** - Claramente indica arquivos Kubernetes
- **`deploy/`** - Genérico, pode incluir vários tipos de deployment

### 🏢 **Padrões da Indústria**
```
Projetos Open Source Comuns:
├── .github/     # GitHub workflows
├── .k8s/        # Kubernetes manifests
├── .docker/     # Docker configs
├── .vscode/     # VS Code settings
```

### 📁 **Organização Mais Clara**
```
Antes (genérico):
├── deploy/
│   ├── Dockerfile
│   ├── k8s-*.yaml
│   ├── docker-compose.yml (?)
│   └── terraform/ (?)

Agora (específico):
├── .k8s/              # Apenas Kubernetes
├── .docker/           # Apenas Docker (se necessário)
├── .terraform/        # Apenas Terraform (se necessário)
```

### 🔍 **Outros Exemplos da Indústria**

| Pasta | Conteúdo | Projetos que usam |
|-------|----------|------------------|
| `.k8s/` | Kubernetes YAML | Istio, Knative, ArgoCD |
| `.github/` | GitHub Actions | Microsoft, Google, Facebook |
| `.vscode/` | VS Code configs | Azure Functions templates |
| `.docker/` | Docker configs | Docker oficial |

### 🚀 **Benefícios da Mudança**

✅ **Mais específico** - Não há dúvidas sobre o conteúdo  
✅ **Padrão da indústria** - Segue convenções estabelecidas  
✅ **Melhor organização** - Cada tecnologia tem sua pasta  
✅ **Facilita ferramentas** - IDEs reconhecem o padrão  
✅ **Escalabilidade** - Fácil adicionar `.docker/`, `.terraform/` etc.

### 📋 **Comandos Atualizados**

```bash
# Deploy commands agora usam .k8s/
kubectl apply -f .k8s/k8s-deployment-local.yaml
kubectl apply -f .k8s/k8s-deployment-dev.yaml
kubectl apply -f .k8s/k8s-deployment-prod.yaml

# Docker build usa .k8s/
docker build -f .k8s/Dockerfile -t app:latest .
```

## 🎯 **Resultado Final**

A estrutura agora está alinhada com as melhores práticas da indústria e facilita:

- **Identificação rápida** do tipo de arquivo
- **Colaboração** com outros desenvolvedores
- **Integração** com ferramentas CI/CD
- **Escalabilidade** para outras tecnologias