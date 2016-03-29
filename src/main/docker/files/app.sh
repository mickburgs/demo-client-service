#!/bin/sh

# Create the micro-service JAVA_OPTS param name,
# for eg. micro-service name = payment-service
# JAVA_OPTS param name will be PAYMENT-SERVICE_OPTS
# It should be in upper case
APP_JAVA_OPTS=${SERVICE_NAME^^[a-z]}_OPTS

# Replace the - with _, so PAYMENT-SERVICE_OPTS = PAYMENT_SERVICE_OPTS
APP_JAVA_OPTS="${APP_JAVA_OPTS//-/_}"

# Split the , separated SERVICE_JAVA_OPTIONS
IFS=',' read -r -a SERVICE_JAVA_OPTS_ARR <<< $SERVICE_JAVA_OPTS

# Thid will concatenate all the SERVICE_JAVA_OPTS with a space.
# for eg. -Dspring.profiles.active = development  -Dserver.port=8194
SERVICE_JAVA_OPTS_VALUES="${SERVICE_JAVA_OPTS_ARR[@]}"

# export the SERVICE_JAVA_OPTS to PAYMENT_SERVICE_OPTS
# so the micro-service sh script can use it 
# and pass the options to JVM
export "$APP_JAVA_OPTS"="$SERVICE_JAVA_OPTS_VALUES"

# If $URL_TO_TAR variable is not set, then we will use the $URL_TO_JAR variable.
if [[ -z "$URL_TO_TAR" ]]; then
  # download the micro-service jar file from jenkins
  curl --location --remote-name --junk-session-cookies --insecure --user realm-jenkins:d2e3ded9b61027018f1eb5ba0297cff9 "$URL_TO_JAR"
  
  # execute the jar file with the provided parameters
  EXEC_JAR_CALL="nohup java -jar $SERVICE_JAVA_OPTS_VALUES ${URL_TO_JAR##*/} >> service.log &"
  echo Calling: $EXEC_JAR_CALL
  $EXEC_JAR_CALL
else
  # download the micro-service tar file from jenkins
  curl --location --remote-name --junk-session-cookies --insecure --user realm-jenkins:d2e3ded9b61027018f1eb5ba0297cff9 "$URL_TO_TAR"

  # decompress the tar file
  tar -xvf "$SERVICE_NAME".tar

  cd "$SERVICE_NAME"/bin

  # start micro-service
  ./"$SERVICE_NAME"
fi
