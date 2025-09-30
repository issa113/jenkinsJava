# Utiliser une image Java officielle comme base
FROM openjdk:11-jdk-alpine

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copier le JAR buildé depuis ton projet Jenkins
COPY target/*.jar app.jar

# Exposer le port de l'application Spring Boot
EXPOSE 8080

# Commande pour démarrer l'application
ENTRYPOINT ["java","-jar","app.jar"]
