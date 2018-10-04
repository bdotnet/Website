FROM nginx:alpine

MAINTAINER Anubhav Ranjan <anubhavranjan@microsoft.com>

ENV HUGO_VERSION="0.49"
ENV GITHUB_USERNAME="bdotnet"
ENV DOCKER_IMAGE_NAME="website"

USER root

RUN echo http://mirror.yandex.ru/mirrors/alpine/v3.8/main > /etc/apk/repositories; \
    echo http://mirror.yandex.ru/mirrors/alpine/v3.8/community >> /etc/apk/repositories
    
RUN apk add --no-cache \
curl \
git \
openssh-client \
ca-certificates \
rsync

RUN mkdir -p /usr/local/src \
    && cd /usr/local/src \
    && curl -L https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_linux-64bit.tar.gz | tar -xz \
    && mv hugo /usr/local/bin/hugo \
    && curl -L https://bin.equinox.io/c/dhgbqpS8Bvy/minify-stable-linux-amd64.tgz | tar -xz \
    && mv minify /usr/local/bin/ \
    && addgroup -Sg 1000 hugo \
    && adduser -SG hugo -u 1000 -h /src hugo

RUN git clone https://github.com/${GITHUB_USERNAME}/${DOCKER_IMAGE_NAME}.git

RUN hugo -s ${DOCKER_IMAGE_NAME} -d /usr/share/nginx/html/ 

EXPOSE 80

CMD nginx -g "daemon off;"