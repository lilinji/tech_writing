## BUILDING
##   (from project root directory)
##   $ docker build -t tomcat-for-lilinji-tech_writing .
##
## RUNNING
##   $ docker run -p 8080:8080 tomcat-for-lilinji-tech_writing
##
## CONNECTING
##   Lookup the IP of your active docker host using:
##     $ docker-machine ip $(docker-machine active)
##   Connect to the container at DOCKER_IP:8080
##     replacing DOCKER_IP for the IP of your active docker host

FROM gcr.io/stacksmith-images/debian-buildpack:wheezy-r9

MAINTAINER Bitnami <containers@bitnami.com>

ENV STACKSMITH_STACK_ID="9awdkwl" \
    STACKSMITH_STACK_NAME="Tomcat for lilinji/tech_writing" \
    STACKSMITH_STACK_PRIVATE="1"

RUN bitnami-pkg install java-1.8.0_101-0 --checksum 66b64f987634e1348141e0feac5581b14e63064ed7abbaf7ba5646e1908219f9
RUN bitnami-pkg install tomcat-8.5.4-0 --checksum d2033af8a2d0d80a027fd8d2142a3ac20568615b34daa2a3cd1d944ba9c106c3 -- --username manager --password bitnami

ENV JAVA_HOME=/opt/bitnami/java \
    CATALINA_HOME=/opt/bitnami/tomcat
ENV PATH=$CATALINA_HOME/bin:/opt/bitnami/java/bin:$PATH

## STACKSMITH-END: Modifications below this line will be unchanged when regenerating

# Tomcat server template
RUN ln -s $CATALINA_HOME/webapps /app
WORKDIR /app
COPY . /app

EXPOSE 8080
CMD ["nami", "start", "--foreground", "tomcat"]
