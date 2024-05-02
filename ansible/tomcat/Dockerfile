###
# Dockerfile for Unidata Tomcat.
###
FROM tomcat:9.0-jdk11

MAINTAINER Unidata

# Install necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends  \
        gosu \
        zip \
        unzip \
        nano \
        && \
    # Cleanup
    apt-get clean && \

RUN mv ${CATALINA_HOME}/webapps ${CATALINA_HOME}/webapps2
RUN mv ${CATALINA_HOME}/webapps.dist ${CATALINA_HOME}/webapps

RUN chmod +x ${CATALINA_HOME}/bin/start-tomcat.sh

EXPOSE 4288
# Start container
ENTRYPOINT ["/entrypoint.sh"]
CMD ["start-tomcat.sh"]