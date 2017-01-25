FROM alpine:latest

MAINTAINER Nyk Cowham <Nicholas.Cowham@corbis.com>

# Install OpenJDK JRE
RUN apk --update add openjdk7-jre

# Set environment variables for Java JRE and Pentaho
ENV JAVA_HOME=/usr/lib/jvm/default-jvm/jre
ENV JRE_HOME=${JAVA_HOME} \
    PENTAHO_JAVA_HOME=${JAVA_HOME} \
    DEST_DIR=/home/pentaho \
    ARCHIVE_FILE=pdi-ce-7.0.0.0-25.zip \
    PENTAHO_HOME=${DEST_DIR}/data-integration \
    PENTAHO_USERNAME=pentaho \
    PATH=${PATH}:${JAVA_HOME}/bin:${JRE_HOME}/bin

# Add a user (user id 500) with no login and create the pentaho home directory.
RUN adduser -h ${DEST_DIR} -s /bin/false -D -u 555 ${PENTAHO_USERNAME}

WORKDIR ${DEST_DIR}

# Get and unpack pdi-ce
RUN wget https://downloads.sourceforge.net/project/pentaho/Data%20Integration/7.0/pdi-ce-7.0.0.0-25.zip \
    && unzip ${ARCHIVE_FILE} \
    && rm -f ${ARCHIVE_FILE}

VOLUME ["/home/pentaho/repository"]

EXPOSE 80

CMD ["/home/pentaho/data-integration/carte.sh", "0.0.0.0", "80"]
