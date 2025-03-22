FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build 
WORKDIR /src

# Copy the project file and restore dependencies
COPY SelectorService.csproj .
RUN dotnet restore

# Copy the rest of the application files, including appsettings.json
COPY . .

# Build the application
RUN dotnet build "SelectorService.csproj" -c Release -o /app/build

# Publish the application
RUN dotnet publish -c release -o /app

# Use the runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# Copy the published files, including appsettings.json
COPY --from=build /app .

# Set the entry point
ENTRYPOINT ["dotnet", "SelectorService.dll"]