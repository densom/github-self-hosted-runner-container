# github-self-hosted-runner-container

## Table of Contents

- [About](#about)
- [Getting Started](#getting_started)
- [Usage](#usage)

## About <a name = "about"></a>

Docker image for running a local Github Action Runner in Docker.

## Getting Started <a name = "getting_started"></a>

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See [deployment](#deployment) for notes on how to deploy the project on a live system.


### Prerequisites

* [Docker](https://docs.docker.com/get-docker/)

## Usage <a name = "usage"></a>

#### To add a runner 
* [Add a runner to your github repo](https://docs.github.com/en/actions/hosting-your-own-runners/adding-self-hosted-runners#adding-a-self-hosted-runner-to-a-repository)
* Copy the token from the instructions after you add the runner
* You can also copy your repo URI from the instructions
#### To run

```
docker run -it -e GITHUB_REG_TOKEN=<your-key> -e GITHUB_URL=https://github.com/<your-repo> densom/self-hosted-runner:latest
```
Or, copy [.env.example](https://github.com/densom/github-self-hosted-runner-container/blob/b6858a9bc72209d7a2d717c8f07a3793b46abb74/.env.example) into .env and change the variables for your project.

```
docker run -it --env-file .env densom/self-hosted-runner:latest
```

```ini
# required
GITHUB_REG_TOKEN=<your-key>
GITHUB_URL=https://github.com/<your-repo>

# optional
GITHUB_RUNNER_NAME=my-local-runner
GITHUB_RUNNER_GROUP=Default
GITHUB_RUNNER_WORKDIR=_work
```