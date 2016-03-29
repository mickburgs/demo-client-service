########################################
## Dockerfile for maxxton-services     #
########################################
FROM java:8
MAINTAINER Mick Burgs <m.burgs@maxxton.com>

########################################
## micro-service setup                 #
########################################
# prepare app environment
ENV SERVICE_HOME /opt/temp
ENV TZ "Europe/Amsterdam"

#Set the timezone inside the docker container
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone

RUN mkdir ${SERVICE_HOME}
ADD files/app.sh ${SERVICE_HOME}/

WORKDIR ${SERVICE_HOME}

CMD bash -C './app.sh';'bash'
