# Dockerfile deve iniciar com a instrução FROM.
FROM maven:3.8.4-openjdk-17-slim AS build

# Cria o diretório
WORKDIR /app

# Copia toda a estrutura do projeto para o diretório
COPY . /app

# Gera o pacote da aplicação
RUN mvn package

FROM openjdk:17-jdk-slim

COPY --from=build /app/target/*.jar /app/app.jar

ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./unrandom", "-jar", "/app/app.jar"] 
