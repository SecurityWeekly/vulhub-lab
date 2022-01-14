FROM kalilinux/kali-rolling

ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm-256color

# Install Kali Headless
RUN rm -fR /var/lib/apt/ && \
    apt-get clean && \
    apt-get update -y && \
    apt-get install -y software-properties-common kali-linux-headless --fix-missing

# Update DB and clean'up!
RUN updatedb && \
    apt-get autoremove -y && \
    apt-get clean 

CMD ["/bin/bash"]
