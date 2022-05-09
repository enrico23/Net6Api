# NET6 API

This is a basic NET6 API project based on the Weather Forecast Template generated using 
dotnet cli

The project runs on Docker
### Run App on Docker
To run on Docker:
* Add Development Certificate
* Trust Development Certificate
* Build image using a Dockerfile
* Run App Using a Docker Container
* Run App using a Docker Compose file
* Set the SSL Certificate password on your local machine

### Add Development Certificate

Example:
```
dotnet dev-certs https -ep $env:USERPROFILE\.aspnet\https\certificate.pfx -p pa55word!
```

### Trust Development Certificate
```
dotnet dev-certs https --trust
```

### Build Image

```
docker build -t enrico23/net6api .
```

### Run App Using a Docker Container

Powershell

```
docker run --rm -it -p 8000:80 -p 8001:443 -v $env:USERPROFILE\.aspnet\https:/https/ enrico23/net6api
```

Bash
```
docker run --rm -it -p 8000:80 -p 8001:443 -v $USERPROFILE/.aspnet/https:/https/ enrico23/net6api
```

### Run App using a Docker Compose file

[NET6 Docker Compose](https://docs.microsoft.com/en-us/aspnet/core/security/docker-compose-https?view=aspnetcore-6.0)

```
docker compose -f "./Build/docker-compose.yml" up -d
```

### Set the SSL Certificate password on your local machine (Windows)

For security reasons, the password of the Development Certificate the .pfx file, can be stored on your local machine as an Environment Variable. 

1. Goto your start bar in Windows
2. Type “Environment Variables”
3. Click on “Edit the system environment variables”
4. Click on “Environment variables”
5. Under “system variables”, click “New” and set the “variable name” to "APP_SSL_CERTIFICATE_PASSWORD"
6. Add your password and save
7. Modify the Docker file to replace the hardcoded value under the command "ENV ASPNETCORE_Kestrel__Certificates__Default__Password" with the value "${APP_SSL_CERTIFICATE_PASSWORD:?err}"
8. Modify the Docker Compose file to replace the hardcoded value under the key "ASPNETCORE_Kestrel__Certificates__Default__Password" with the value "${APP_SSL_CERTIFICATE_PASSWORD:?err}"