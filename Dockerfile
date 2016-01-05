FROM alpine:3.3

MAINTAINER Nyk Cowham <Nicholas.Cowham@corbis.com>

# Install OpenJDK JRE
RUN apk --update add openjdk7-jre

# Set environment variables for Java JRE and Pentaho
ENV JAVA_HOME=/usr/lib/jvm/default-jvm/jre
ENV JRE_HOME=${JAVA_HOME} \
    PENTAHO_JAVA_HOME=${JAVA_HOME} \
    PENTAHO_HOME=/home/pentaho/data-integration \
    PATH=${PATH}:${JAVA_HOME}/bin:${JRE_HOME}/bin

# Add a user (user id 500) with no login and create the pentaho home directory.
RUN adduser -h /home/pentaho -s /bin/false -D -u 555 pentaho

# Get and unpack pdi-ce 6.0 stable.
ADD http://downloads.sourceforge.net/project/pentaho/Data%20Integration/6.0/pdi-ce-6.0.1.0-386.zip /home/pentaho
RUN unzip /home/pentaho/pdi-ce-6.0.1.0-386.zip && rm -f /home/pentaho/pdi-ce-6.0.1.0-386.zip

VOLUME ["/var/local/data-integration/repository"]

WORKDIR $PENTAHO_HOME

EXPOSE 80

CMD ["./carte.sh", "0.0.0.0", "80"]