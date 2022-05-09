FROM mcr.microsoft.com/dotnet/aspnet:6.0-focal AS base
WORKDIR /app

EXPOSE 8080

ENV ASPNETCORE_URLS=http://*:8080;

# Creates a non-root user with an explicit UID and adds permission to access the /app folder
# For more info, please refer to https://aka.ms/vscode-docker-dotnet-configure-containers
RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /app
USER appuser

FROM mcr.microsoft.com/dotnet/sdk:6.0-focal AS build
WORKDIR /src
COPY ["src/App.Web.Rest/App.Web.Rest.csproj", "src/App.Web.Rest/"]
RUN dotnet restore "src/App.Web.Rest/App.Web.Rest.csproj"
COPY . .
WORKDIR "/src/src/App.Web.Rest"
RUN dotnet build "App.Web.Rest.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "App.Web.Rest.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "App.Web.Rest.dll"]