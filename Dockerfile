# Use official .NET 6 SDK image for build
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

WORKDIR /app

# Copy the csproj and restore dependencies
COPY ["BlazeTournaments.csproj", "./"]
RUN dotnet restore

# Copy the rest of the source code
COPY . ./

# Publish the app
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app/out .

ENTRYPOINT ["dotnet", "BlazeTournaments.dll"]
