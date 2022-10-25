# base
FROM ubuntu:18.04

# set the github runner version
ARG RUNNER_VERSION="2.298.2"

# update the base packages and add a non-sudo user

# install python and the packages the your code depends on along with jq so we can parse JSON
# add additional packages as necessary

# cd into the user directory, download and unzip the github actions runner

# install some additional dependencies

RUN apt-get update -y && apt-get upgrade -y && useradd -m docker \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    curl jq build-essential libssl-dev libffi-dev python3 python3-venv python3-dev python3-pip \
    && cd /home/docker && mkdir actions-runner && cd actions-runner \
    && curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && chown -R docker ~docker && /home/docker/actions-runner/bin/installdependencies.sh \
    && rm -rf /var/lib/apt/lists/*


# copy over the start.sh script
COPY start.sh start.sh

# make the script executable
RUN chmod +x start.sh

ENV GITHUB_REG_TOKEN=""
ENV GITHUB_URL=""
ENV GITHUB_RUNNER_GROUP="Default"
ENV GITHUB_RUNNER_NAME="local-docker-runner"
ENV GITHUB_RUNNER_WORKDIR="_work"

# since the config and run script for actions are not allowed to be run by root,
# set the user to "docker" so all subsequent commands are run as the docker user
USER docker

# set the entrypoint to the start.sh script
ENTRYPOINT ["./start.sh"]