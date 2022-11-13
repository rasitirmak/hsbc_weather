FROM maven
WORKDIR /app
COPY . .
RUN mvn clean package
#CMD java ./welcome.py
#CMD ["java", "-jar", "my-app-1.0-SNAPSHOT.jar"]
CMD ["java", "-jar", "/target/my-app-1.0-SNAPSHOT.jar"]