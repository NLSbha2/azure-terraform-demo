FROM eclipse-temurin:17-jre-alpine
LABEL maintainer="SDK Team"

RUN groupadd -r appRunner && useradd -r -s /bin/false -g appRunner appRunner
RUN mkdir /app
WORKDIR /app

COPY build/libs/demo-*-SNAPSHOT.jar app.jar

RUN chown -R appRunner:appRunner /app

EXPOSE 8080
EXPOSE 8081 # management
USER appRunner
ENTRYPOINT ["java", "-jar", "app.jar"]