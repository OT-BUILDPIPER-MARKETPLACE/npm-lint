#!/bin/bash

source functions.sh
source log-functions.sh
source str-functions.sh
source file-functions.sh
source aws-functions.sh

logInfoMessage "I'll lint the JS files available at [$WORKSPACE/$CODEBASE_DIR]"

cd  $WORKSPACE/$CODEBASE_DIR

if [ -d "reports" ]; then
    true
else
    mkdir reports 
fi

jshint --extract always .

if [ $? -eq 0 ]
then
  logInfoMessage "Congratulations js lint scan succeeded!!!"
  generateOutput docker_lint true "Congratulations js lint scan succeeded!!!"
elif [ $VALIDATION_FAILURE_ACTION == "FAILURE" ]
  then
    logErrorMessage "Please check npm lint scan failed!!!"
    generateOutput ${ACTIVITY_SUB_TASK_CODE} false "Please check js lint scan failed with warnings!!!"
    exit 1
   else
    logWarningMessage "Please check npm lint scan failed!!!"
    generateOutput ${ACTIVITY_SUB_TASK_CODE} true "Please check js lint scan failed with warnings!!!"
fi