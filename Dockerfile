FROM node:16.11.0-buster

RUN apt-get update -y
RUN apt-get install jq -y

WORKDIR /src/
RUN npm update
RUN npm install -g jshint

COPY build.sh .
COPY BP-BASE-SHELL-STEPS .

ENV ACTIVITY_SUB_TASK_CODE BP-DOCKER-LINTER
ENV SLEEP_DURATION 5s
ENV VALIDATION_FAILURE_ACTION WARNING

ENTRYPOINT [ "./build.sh" ]