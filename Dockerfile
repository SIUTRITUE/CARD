FROM tomcat:10.1-jdk17

# Xóa webapps mặc định
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR build từ Maven (chú ý đúng tên file trong target/)
COPY target/web-demo.war /usr/local/tomcat/webapps/ROOT.war

# Render sẽ cấp PORT động, Tomcat dùng biến này
ENV CATALINA_OPTS="-Dserver.port=$PORT"

EXPOSE 8080

CMD ["catalina.sh", "run"]
