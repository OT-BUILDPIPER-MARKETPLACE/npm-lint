#!/bin/bash

source functions.sh
source log-functions.sh
source str-functions.sh
source file-functions.sh
source aws-functions.sh

CODE_LOCATION="${WORKSPACE}"/"${CODEBASE_DIR}"
logInfoMessage "I'll do processing at [$CODE_LOCATION]"
sleep  $SLEEP_DURATION

logInfoMessage "I'll ${INSTRUCTION} for files available at [$CODE_LOCATION]"

cd  "${CODE_LOCATION}"

# npm install

# # Check npm install status
# if [ $? -eq 0 ]; then
#     TASK_STATUS=0
#     logInfoMessage "Successfully installed npm"
# else
#     TASK_STATUS=1
#     logErrorMessage "Failed to install npm"
#     exit 1
# fi

if [ -d "reports" ]; then
    true
else
    mkdir reports 
fi

npm ${INSTRUCTION}

if [ $? -eq 0 ]
then
  logInfoMessage "Congratulations npm ${INSTRUCTION} succeeded!!!"
  generateOutput docker_lint true "Congratulations npm ${INSTRUCTION} succeeded!!!"
elif [ $VALIDATION_FAILURE_ACTION == "FAILURE" ]
  then
    logErrorMessage "Please check NPM failed!!!"
    generateOutput ${ACTIVITY_SUB_TASK_CODE} false "Please check js npm ${INSTRUCTION} with warnings!!!"
    exit 1
   else
    logWarningMessage "Please check NPM failed!!!"
    generateOutput ${ACTIVITY_SUB_TASK_CODE} true "Please check js npm ${INSTRUCTION} with warnings!!!"
fi