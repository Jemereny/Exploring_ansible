FROM ubuntu:16.04

# SSH
RUN apt-get update && apt-get install openssh-server -y
RUN mkdir -p /var/run/sshd

# authorize SSH connection with root account
RUN sed -i '/^#/!s/PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config

# change password
RUN echo "root:docker" | chpasswd

RUN apt-get install software-properties-common -y

WORKDIR /app/

COPY . .

RUN chmod +x ./entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
