FROM nginx
MAINTAINER Sid

RUN apt-get update && \
    apt-get install -y sudo &&\
    apt-get install -y python3 &&\
    apt-get install -y python3-pip && \
    pip3 install markdown && \
    pip3 install mkdocs && \
    pip3 install mkdocs-material && \
    useradd -ms /bin/bash essay && \
    echo "essay ALL = (ALL) NOPASSWD:ALL" > /etc/sudoers

COPY essay /usr/share/nginx/html
COPY config/default.conf /etc/nginx/conf.d/default.conf

WORKDIR /usr/share/nginx/html
RUN mkdocs build

USER essay

CMD sudo service nginx start && sleep infinity