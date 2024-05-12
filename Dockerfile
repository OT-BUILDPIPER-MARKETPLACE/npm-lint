FROM node:16.11-stretch-slim

RUN apk add --no-cache --upgrade bash
RUN apk add jq
RUN npm install -g npm@9

COPY build.sh .
COPY BP-BASE-SHELL-STEPS .

ENV ACTIVITY_SUB_TASK_CODE BP-DOCKER-LINTER
ENV SLEEP_DURATION 5s
ENV VALIDATION_FAILURE_ACTION WARNING
ENV DOCKERFILE_PATH "Dockerfile"

ENTRYPOINT [ "./build.sh" ]