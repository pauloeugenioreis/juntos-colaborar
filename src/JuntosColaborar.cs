using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;
using System.Text;

namespace JuntosColaborar;

public class JuntosColaborarFunction
{
    private readonly ILogger<JuntosColaborarFunction> _logger;

    public JuntosColaborarFunction(ILogger<JuntosColaborarFunction> logger)
    {
        _logger = logger;
    }

    [Function("JuntosColaborar")]
    public void Run(
        [RabbitMQTrigger(
            "dev.demo.juntos.colaborar",
            ConnectionStringSetting = "RabbitMQConnectionString")] 
        byte[] message)
    {
        try
        {
            var messageContent = Encoding.UTF8.GetString(message);
            
            _logger.LogInformation("Mensagem recebida da fila 'dev.demo.juntos.colaborar': {Message}", messageContent);
            
            // Aqui você pode processar a mensagem conforme necessário
            ProcessMessage(messageContent);
            
            _logger.LogInformation("Mensagem processada com sucesso!");
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Erro ao processar mensagem da fila RabbitMQ");
            throw; // Re-throw para que o RabbitMQ saiba que houve erro
        }
    }

    private void ProcessMessage(string messageContent)
    {
        // Implementar a lógica de processamento da mensagem aqui
        _logger.LogInformation("Processando mensagem: {Content}", messageContent);
        
        // Exemplo de processamento simples
        // Você pode adicionar sua lógica de negócio aqui
    }
}