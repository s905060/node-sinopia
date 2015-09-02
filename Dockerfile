############################################################
# Dockerfile to build Node.js Sinopia
# Based on Node
############################################################

# Set the base image to CentOS
FROM centos:centos6

# File Author / Maintainer
MAINTAINER "Jash Lee" <s905060@gmail.com>

# Set env variables
ENV SINOPIA_DIR /sinopia
ENV SINOPIA_DATA /sinopia/storage

# Install nodejs && npm
RUN yum -y install epel-release
RUN yum -y install nodejs npm --enablerepo=epel

# Make Sinopia directory
RUN \
    mkdir -p ${SINOPIA_DIR} && \
    mkdir -p ${SINOPIA_DATA}

# Sinopia Version / Path / Backup
ENV version v1.4.0
RUN git clone https://github.com/rlidwka/sinopia
WORKDIR /sinopia
RUN git checkout $version
RUN npm install --production

# Clean
RUN rm -rf .git
RUN npm cache clean

# Adding the run file
ADD config.yaml /sinopia/config.yaml

# Sinopia service port
EXPOSE 4873

# Mounted config
VOLUME ["/sinopia/config.yaml", "/sinopia/storage"]

# Start the Sinopia service
CMD ["./bin/sinopia"]
