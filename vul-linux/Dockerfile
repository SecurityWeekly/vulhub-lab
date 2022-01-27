FROM debian:jessie

MAINTAINER t0kx <t0kx@protonmail.ch>

# install debian stuff
RUN apt-get update && \
    apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    wget libpam0g-dev build-essential policykit-1 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# configure vuln application
RUN wget --no-check-certificate https://www.sudo.ws/dist/OLD/sudo-1.7.2.tar.gz -O /tmp/sudo.tar.gz && \
    tar xfz /tmp/sudo.tar.gz -C /tmp/ && \
    cd /tmp/sudo-1.7.2 && \
    ./configure && \
    make && make install
RUN rm -rf /tmp/sudo*

# create default user
RUN useradd -d /home/user \
    -s /bin/bash \
    -ms /bin/bash user

# add sudoers entry
RUN echo 'user ALL=NOPASSWD: sudoedit /etc/fstab' >> /etc/sudoers

USER user
# run interactive shell
# with user privileges
#CMD ["su", "-", "user"]
CMD ["/bin/bash"]
