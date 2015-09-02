############################################################
# Dockerfile to build Node.js Sinopia
# Based on Node
############################################################

# Set the base image to node
FROM node

# File Author / Maintainer
MAINTAINER "Jash Lee" <s905060@gmail.com>

# Set env variables
ENV SINOPIA_DATA_DIR /root/sinopia/storage

# Install Sinopia
RUN \
    npm install sinopia && \
    mkdir -p ${SINOPIA_DATA_DIR}

# Adding the run file
ADD config.yaml /root/.config/sinopia/config.yaml

# Sinopia service port
EXPOSE 4873

# Mounted config
VOLUME ["/root/.config/sinopia/config.yaml", "/root/sinopia/storage"]

# Start the Sinopia service
CMD ["./bin/sinopia"]
