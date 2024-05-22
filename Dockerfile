FROM node:22

RUN apt-get update -y
RUN apt-get install -y jq apt-utils
RUN npm install -g npm@10.8.0
RUN npm install -g jest
RUN npm install typescript -g
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

# WORKDIR /src/
# RUN npm update
# RUN npm install --save-dev jest

ENV INSTRUCTION ""

COPY build.sh .
COPY BP-BASE-SHELL-STEPS .

ENV ACTIVITY_SUB_TASK_CODE BP-DOCKER-LINTER
ENV SLEEP_DURATION 5s
ENV VALIDATION_FAILURE_ACTION WARNING

ENTRYPOINT [ "./build.sh" ]