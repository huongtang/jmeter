# Use alpine
FROM alpine:3.9

MAINTAINER huong.tang

#JMeter version 
ARG JMETER_VERSION=5.1.1

#Install few utilities 
RUN apk update \
	&& apk upgrade \
	&& apk add ca-certificates \
	&& update-ca-certificates \
	&& apk add --update openjdk8-jre bash

#Install JMeter 
RUN mkdir /jmeter \
&& cd /jmeter/ \
&& wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz \
&& tar -xzf apache-jmeter-${JMETER_VERSION}.tgz \
&& rm apache-jmeter-${JMETER_VERSION}.tgz

#ADD properties file
#ADD /jmeter.properties /jmeter/apache-jmeter-${JMETER_VERSION}/bin
COPY jmeter.properties /jmeter/apache-jmeter-${JMETER_VERSION}/bin
ADD rmi_keystore.jks /jmeter/apache-jmeter-${JMETER_VERSION}/bin 

#ADD the Jmeter Scripts and Test data file folder from local to container 
ADD /JMeterFiles JMeterFiles

#Set JMeter Home 
ENV JMETER_HOME /jmeter/apache-jmeter-${JMETER_VERSION}/

#Add JMeter to the Path 
ENV PATH $JMETER_HOME/bin:$PATH