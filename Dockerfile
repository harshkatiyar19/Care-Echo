# -------- Stage 1: Build --------
FROM openjdk:24-jdk-slim AS builder

WORKDIR /app

# Copy Maven wrapper and project files
COPY mvnw ./
COPY .mvn .mvn
COPY pom.xml ./

# Download dependencies
RUN ./mvnw dependency:go-offline -B

# Copy rest of the source code
COPY src ./src

# Build the application
RUN ./mvnw clean package -DskipTests

# -------- Stage 2: Runtime --------
FROM openjdk:24-jre-slim

WORKDIR /app

# Copy the built JAR
COPY --from=builder /app/target/*.jar app.jar

# Create non-root user
RUN addgroup --system spring && adduser --system spring --ingroup spring
USER spring:spring

# Expose default Spring Boot port
EXPOSE 8080

# Set optional JVM options
ENV JAVA_OPTS="-Xmx512m -Xms256m"

# Optional health check (if Actuator is included)
# HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
#   CMD curl -f http://localhost:8080/actuator/health || exit 1

# Launch the app
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
