FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

# Add NuGet source
RUN dotnet nuget add source https://api.nuget.org/v3/index.json -n nuget.org

COPY ["BlazeTournaments.csproj", "./"]
RUN dotnet restore "BlazeTournaments.csproj"

COPY . .
WORKDIR "/src/."
RUN dotnet build "BlazeTournaments.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "BlazeTournaments.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "BlazeTournaments.dll"]