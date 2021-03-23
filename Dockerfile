FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive
ARG NODE_VERSION=14

RUN apt-get update && apt-get install -y curl gnupg make nginx supervisor

#Install Node
RUN curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | -E bash -

#Install Yarn v1
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y nodejs yarn
RUN apt-get clean && apt-get autoclean

COPY nginx.conf /etc/nginx/nginx.conf
COPY supervisor.conf /etc/supervisor/conf.d/supervisor.conf

WORKDIR /app

EXPOSE 80
