############################################################
# Dockerfile to build Node.js Sinopia
# Based on Node
############################################################

# Set the base image to CentOS
FROM centos:centos6

# File Author / Maintainer
MAINTAINER "Jash Lee" <s905060@gmail.com>

# Clean up yum repos to save spaces
RUN yum update -y >/dev/null

# Install epel
RUN yum -y install epel-release

# Install nodejs && npm
RUN yum -y install git nodejs npm --enablerepo=epel

# Add Sinopia user
ENV USER sinopia
RUN useradd -ms /bin/bash ${USER}
ENV WORK_PATH /home/${USER}/sinopia

USER ${USER}

# Sinopia Version / Path / Backup
ENV version v1.4.0
RUN git clone https://github.com/rlidwka/sinopia
WORKDIR ${WORK_PATH}
RUN git checkout $version
RUN npm install --production

# Clean
RUN rm -rf .git
RUN npm cache clean

# Adding the run file
ADD config.yaml ${WORK_PATH}/config.yaml

# Sinopia service port
EXPOSE 4873

# Mounted config
VOLUME ${WORK_PATH}/storage

# Start the Sinopia service
CMD ["./bin/sinopia"]
