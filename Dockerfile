FROM ubuntu:latest
LABEL maintainer="Valentin Rudloff <valentin.rudloff.perso@gmail.com>"

# Update apt and install sudo
RUN apt update && \
    apt-get -qy full-upgrade && \
    apt install sudo -y

# Install curl and Docker
RUN apt-get install -qy curl && \
    curl -sSL https://get.docker.com/ | sh

# Add user
RUN useradd -rm -d /home/visualstudio -s /bin/bash -G sudo -u 1000 visualstudio && \
    echo 'visualstudio:visualstudio' | chpasswd && \
    echo "sudouser ALL=(ALL) ALL, !/bin/su" >> /etc/sudoers && \
    echo "visualstudio ALL=(ALL) NOPASSWD:ALL, !/bin/su" >> /etc/sudoers

# Install ssh server
RUN apt-get install -y openssh-server && \
    mkdir /var/run/sshd && \
    chmod -R 755 /var/run/sshd && \
    sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -ri 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config && \
    sed -ri 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config && \
    sed -ri 's/#AuthorizedKeysFile/AuthorizedKeysFile/g' /etc/ssh/sshd_config && \
    sed -ri 's/.ssh\/authorized_keys/\/home\/visualstudio\/.ssh\/authorized_keys/g' /etc/ssh/sshd_config

RUN service ssh start

EXPOSE 22

# Clean apt
RUN sudo apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/usr/sbin/sshd","-D"]