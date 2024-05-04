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
    rm -rf /var/lib/apt/lists/* && \
    # Eliminate default web applications
    # rm -rf ${CATALINA_HOME}/webapps/* && \
    # rm -rf ${CATALINA_HOME}/webapps.dist && \
    # Obscuring server info
    cd ${CATALINA_HOME}/lib && \
    mkdir -p org/apache/catalina/util/ && \
    unzip -j catalina.jar org/apache/catalina/util/ServerInfo.properties \
        -d org/apache/catalina/util/ && \
    sed -i 's/server.info=.*/server.info=Apache Tomcat/g' \
        org/apache/catalina/util/ServerInfo.properties && \
    zip -ur catalina.jar \
        org/apache/catalina/util/ServerInfo.properties && \
    rm -rf org && cd ${CATALINA_HOME} && \
    # Setting restrictive umask container-wide
    echo "session optional pam_umask.so" >> /etc/pam.d/common-session && \
    sed -i 's/UMASK.*022/UMASK           007/g' /etc/lo gin.defs 

# RUN cp -R ${CATALINA_HOME}/webapp.dist/* webapps
RUN mv ${CATALINA_HOME}/webapps ${CATALINA_HOME}/webapps2
RUN mv ${CATALINA_HOME}/webapps.dist ${CATALINA_HOME}/webapps

COPY ./*.war ${CATALINA_HOME}/webapps
# RUN chmod +x ${CATALINA_HOME}/bin/start-tomcat.sh

EXPOSE 8082
