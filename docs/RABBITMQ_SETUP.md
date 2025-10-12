# Instruções para Configurar a Fila RabbitMQ

## Passo a Passo para Criar a Fila

### 1. Acessar o RabbitMQ Management UI
- Abra o navegador e acesse: http://rabbitmq.local
- Faça login com:
  - **Usuário**: guest
  - **Senha**: guest

### 2. Criar a Fila
1. Clique na aba **"Queues and Streams"**
2. Role para baixo até a seção **"Add a new queue"**
3. Preencha os campos:
   - **Virtual host**: / (deixe como padrão)
   - **Name**: `dev.demo.juntos.colaborar`
   - **Durability**: Selecione **"Durable"** (para persistir a fila mesmo se o RabbitMQ reiniciar)
   - **Auto delete**: Deixe **"No"** (para não apagar automaticamente)
   - **Arguments**: Deixe vazio (pode ser usado para configurações avançadas)

4. Clique no botão **"Add queue"**

### 3. Verificar se a Fila foi Criada
- Você deve ver a fila `dev.demo.juntos.colaborar` na lista de filas
- O status deve mostrar "idle" ou "running"

### 4. Testar Enviando uma Mensagem
1. Clique no nome da fila `dev.demo.juntos.colaborar`
2. Role para baixo até a seção **"Publish message"**
3. Configure a mensagem:
   - **Payload**: Digite uma mensagem de teste, por exemplo:
     ```json
     {
       "id": 1,
       "message": "Olá JuntosColaborar!",
       "timestamp": "2025-10-12T10:00:00Z"
     }
     ```
   - **Headers**: (opcional) Pode deixar vazio
   - **Properties**: (opcional) Pode deixar os padrões

4. Clique em **"Publish message"**

### 5. Monitorar a Fila
- Na página da fila, você pode ver:
  - **Total messages**: Número total de mensagens
  - **Ready**: Mensagens prontas para consumo
  - **Unacked**: Mensagens sendo processadas
  - **Message rates**: Taxa de mensagens por segundo

## Configurações Importantes

### Configuração da Fila (Recomendado)
- **Durability**: Durable (para persistir durante reinicializações)
- **Auto Delete**: No (para não apagar automaticamente)
- **Exclusive**: No (para permitir múltiplos consumidores)

### Configuração de Mensagens (Opcional)
- **Delivery mode**: 2 (Persistent) - para persistir mensagens
- **Priority**: 0 (padrão)

## Testando a Integração

### 1. Com a Azure Function Rodando Localmente
```bash
# No terminal do projeto
./build.sh
# Escolha opção 3 (Executar localmente)
```

### 2. Enviando Mensagens
- Use o RabbitMQ UI conforme descrito acima
- A Azure Function deve processar e fazer log das mensagens

### 3. Verificando os Logs
- No terminal onde a function está rodando, você verá logs como:
```
[2025-10-12T10:00:00.000Z] Mensagem recebida da fila 'dev.demo.juntos.colaborar': {"id": 1, "message": "Olá JuntosColaborar!", "timestamp": "2025-10-12T10:00:00Z"}
[2025-10-12T10:00:00.001Z] Processando mensagem: {"id": 1, "message": "Olá JuntosColaborar!", "timestamp": "2025-10-12T10:00:00Z"}
[2025-10-12T10:00:00.002Z] Mensagem processada com sucesso!
```

## Troubleshooting

### Problema: Não consigo acessar rabbitmq.local
- Verifique se o RabbitMQ está rodando
- Teste com localhost: http://localhost:15672

### Problema: Fila não aparece
- Verifique se você está no virtual host correto (/)
- Confirme se clicou em "Add queue"

### Problema: Azure Function não consome mensagens
- Verifique a connection string no `local.settings.json`
- Confirme se o RabbitMQ está acessível na porta 5672
- Verifique os logs da function para erros de conexão