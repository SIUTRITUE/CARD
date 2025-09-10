# --- Stage 1: Build WAR bằng Maven ---
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
# copy cấu hình trước để cache dependency
COPY pom.xml .
RUN mvn -B -q -DskipTests dependency:go-offline

# copy source rồi build
COPY src ./src
RUN mvn -B -DskipTests package

# --- Stage 2: Chạy Tomcat và deploy WAR ---
FROM tomcat:10.1-jdk17

# Xoá webapps mặc định
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR đã build sang ROOT.war
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Render yêu cầu app lắng nghe đúng $PORT, Tomcat mặc định 8080
# Ta chỉnh server.xml trước khi start để dùng $PORT
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

EXPOSE 8080
CMD ["/usr/local/bin/run.sh"]
