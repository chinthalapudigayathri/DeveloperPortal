# Use Java 21 runtime
FROM eclipse-temurin:21-jdk AS build

# Set working directory
WORKDIR /app

# Copy Maven/Gradle wrapper and source
COPY . .

# Build the JAR (adjust if using Gradle)
RUN ./mvnw clean package -DskipTests

# Runtime image
FROM eclipse-temurin:21-jre
WORKDIR /app

# Copy built JAR
COPY --from=build /app/target/*.jar app.jar

# Expose port
EXPOSE 8080

# Run the app
ENTRYPOINT ["java","-jar","app.jar"]