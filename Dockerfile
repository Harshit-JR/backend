# Use the official .NET SDK image
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

WORKDIR /app

# Copy the .csproj file and restore dependencies
COPY ["BlazeTournaments.csproj", "./"]
RUN dotnet restore

# Copy the rest of the app
COPY . ./

# Build the application
RUN dotnet publish -c Release -o out

# Use a smaller runtime image
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=build /app/out .

ENTRYPOINT ["dotnet", "BlazeTournaments.dll"]
