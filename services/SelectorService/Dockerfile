FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build 
WORKDIR /src

COPY SelectorService.csproj .
RUN dotnet restore

COPY . .

RUN dotnet build "SelectorService.csproj" -c Release -o /app/build

RUN dotnet publish -c release -o /app

COPY appsettings.json /app/appsettings.json

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

COPY --from=build /app .

ENTRYPOINT ["dotnet", "SelectorService.dll"]