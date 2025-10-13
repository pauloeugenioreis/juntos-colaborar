# Build Stage: Compiles the .NET project
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy solution and project files to restore dependencies
COPY demo.sln .
COPY src/ ./src/

# Restore dependencies using the solution file
RUN dotnet restore demo.sln

# Publish the application for release
RUN dotnet publish "src/JuntosColaborar.csproj" -c Release -o /app/publish

# Final Stage: Creates the runtime image
FROM mcr.microsoft.com/azure-functions/dotnet-isolated:4-dotnet-isolated8.0
WORKDIR /home/site/wwwroot

# Copy the published artifacts from the build stage
COPY --from=build /app/publish .

# Set environment variables for Azure Functions
ENV AzureWebJobsScriptRoot=/home/site/wwwroot \
    AzureFunctionsJobHost__Logging__Console__IsEnabled=true
