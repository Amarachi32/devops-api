# Stage 1: Build the API
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY InfinionDevOps.csproj ./
RUN dotnet restore "InfinionDevOps.csproj"

# Copy everything else
COPY . ./

# Publish the application
RUN dotnet publish "InfinionDevOps.csproj" -c Release -o /app/publish

# Stage 2: Runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app

COPY --from=build /app/publish .

ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

ENTRYPOINT ["dotnet", "InfinionDevOps.dll"]
