FROM maven:3-jdk-8 as mavenbuild
COPY . openmrs-core
RUN cd openmrs-core && \
    mvn clean package 


FROM tomcat:8
LABEL AUTHOR=balaji
LABEL app=openmrs
EXPOSE 8080
VOLUME /root/.OpenMRS
COPY --from=mavenbuild /openmrs-core/webapp/target/openmrs.war /usr/local/tomcat/webapps/openmrs.war
CMD ["catalina.sh", "run"]
