FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY ["SISTEMA PQRSF - Aeronáutico Civil ELYON YIREH.csproj", "./"]
RUN dotnet restore "SISTEMA PQRSF - Aeronáutico Civil ELYON YIREH.csproj"

COPY . .
RUN dotnet publish "SISTEMA PQRSF - Aeronáutico Civil ELYON YIREH.csproj" \
    -c Release \
    -o /app/publish \
    /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish .

ENV ASPNETCORE_URLS=http://+:10000
EXPOSE 10000
ENTRYPOINT ["dotnet", "SISTEMA PQRSF - Aeronáutico Civil ELYON YIREH.dll"]
