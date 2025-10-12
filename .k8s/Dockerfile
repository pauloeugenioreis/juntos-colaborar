# Dockerfile simplificado - usa binários pré-compilados
FROM mcr.microsoft.com/azure-functions/dotnet-isolated:4-dotnet-isolated8.0

ENV AzureWebJobsScriptRoot=/home/site/wwwroot \
    AzureFunctionsJobHost__Logging__Console__IsEnabled=true

# Copia binários já compilados localmente
COPY publish/ /home/site/wwwroot/