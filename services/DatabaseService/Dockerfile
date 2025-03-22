FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build 
WORKDIR /src
COPY DatabaseService.csproj .
RUN dotnet restore
COPY . .

RUN dotnet build "DatabaseService.csproj" -c Release -o /app/build

RUN dotnet publish -c release -o /app

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["dotnet", "DatabaseService.dll"]

