#!/bin/bash

cd ..

if [ ! -d "services" ]; then
  mkdir services
else
  echo "Directory 'services' already exists."
fi

cd services || exit

projectsList=("EndpointService" "SelectorService" "DatabaseService" "CacheService")


for project in "${projectsList[@]}"
do
    case $project in 

        # Endpoint Service
        "EndpointService")
          dotnet new webapi -o "EndpointService"
          cd EndpointService
          dotnet add package Swashbuckle.AspNetCore
          dotnet add package Microsoft.AspNetCore.OpenApi
          dotnet add package Microsoft.Azure.ServiceBus
          echo "FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build 
WORKDIR /src
COPY $project.csproj .
RUN dotnet restore
COPY . .

RUN dotnet build \"EndpointService.csproj\" -c Release -o /app/build

RUN dotnet publish -c release -o /app

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT [\"dotnet\", \"EndpointService.dll\"]
" > Dockerfile
    cd ..
          echo "-----------------------------------"
          echo "EndpointService creado correctamente"
          echo "-----------------------------------"
          ;;

        # Selector Service
        "SelectorService")
          dotnet new console -o "SelectorService"
          cd "SelectorService"
          dotnet add package Microsoft.Azure.ServiceBus
          dotnet add package Microsoft.Extensions.Configuration.Json
          echo "FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build 
WORKDIR /src
COPY SelectorService.csproj .
RUN dotnet restore
COPY . .

RUN dotnet build \"SelectorService.csproj\" -c Release -o /app/build

RUN dotnet publish -c release -o /app

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT [\"dotnet\", \"SelectorService.dll\"]
" > Dockerfile
    cd ..
          echo "-----------------------------------"
          echo "SelectorService creado correctamente"
          echo "-----------------------------------"
          ;;

        # Database Service
        "DatabaseService")
          dotnet new console -o "DatabaseService"
          cd "DatabaseService"
          dotnet add package Azure.Messaging.ServiceBus
          dotnet add package Microsoft.EntityFrameworkCore
          dotnet add package Microsoft.EntityFrameworkCore.SqlServer
          dotnet add package Microsoft.Extensions.Configuration
          dotnet add package Microsoft.Extensions.Configuration.FileExtensions
          dotnet add package Microsoft.Extensions.Configuration.Json
          dotnet add package System.Data.SqlClient
          echo "FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build 
WORKDIR /src
COPY DatabaseService.csproj .
RUN dotnet restore
COPY . .

RUN dotnet build \"DatabaseService.csproj\" -c Release -o /app/build

RUN dotnet publish -c release -o /app

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT [\"dotnet\", \"DatabaseService.dll\"]
" > Dockerfile
    cd ..    
          echo "-----------------------------------"
          echo "DatabaseService creado correctamente"
          echo "-----------------------------------"      
          ;;

        # Cache Service
        "CacheService")
        dotnet new console -o "CacheService"
        cd "CacheService"
        echo "FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build 
WORKDIR /src
COPY CacheService.csproj .
RUN dotnet restore
COPY . .

RUN dotnet build \"CacheService.csproj\" -c Release -o /app/build

RUN dotnet publish -c release -o /app

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT [\"dotnet\", \"CacheService.dll\"]
" > Dockerfile
    cd .. 
          echo "-----------------------------------"
          echo "CacheService creado correctamente"
          echo "-----------------------------------"
          ;;
    esac
done

echo "-----------------------------------"
echo "4 proyectos creados correctamente con Dockerfile y dependendencias necesarias"
echo "-----------------------------------"

          echo "
services:
  endpointservice:
    image: endpointservice
    build:
      context: ./EndpointService
      dockerfile: Dockerfile
    ports:
      - '8080:8080'

  selectorservice:
    image: selectorservice
    build:
      context: ./SelectorService
      dockerfile: Dockerfile

  databaseservice:
    image: databaseservice
    build:
      context: ./DatabaseService
      dockerfile: Dockerfile

  cacheservice:
    image: cacheservice
    build:
      context: ./CacheService
      dockerfile: Dockerfile
" > docker-compose.yml

echo "-----------------------------------"
echo "Docker compose creado correctamente"
echo "-----------------------------------"

cd ..

cd infra

terraform init

terraform plan -out plan.out

terraform apply plan.out

cd ..

echo "-----------------------------------"
echo "Grupo de recursos y Service Bus creado correctamente"
echo "-----------------------------------"

