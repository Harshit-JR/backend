# Use official .NET SDK image
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

# Set working directory inside container
WORKDIR /app

# Copy csproj and restore dependencies
COPY ["BlazeTournaments.csproj", "./"]
RUN dotnet restore --source https://api.nuget.org/v3/index.json

# Copy the rest of the code
COPY . .

# Build the project
RUN dotnet publish -c Release -o out

# Runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app/out .

ENTRYPOINT ["dotnet", "BlazeTournaments.dll"]
