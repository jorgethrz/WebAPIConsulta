FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /source
COPY . .
RUN dotnet restore "./WebAPIConsulta.csproj"
RUN dotnet publish "./WebAPIConsulta.csproj" -c Release -o /app/publish --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish .

EXPOSE 8000
EXPOSE 8001

ENTRYPOINT ["dotnet", "WebAPIConsulta.dll"]