FROM eclipse-temurin:21-jdk AS build
WORKDIR /app
COPY gradlew gradlew.bat settings.gradle build.gradle ./
COPY gradle gradle
RUN chmod +x gradlew
COPY src src
RUN ./gradlew --no-daemon bootJar -x test

FROM eclipse-temurin:21-jre AS runtime
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
