FROM ubuntu:22.04

# Install DEV tools
RUN apt update && apt-get install -y wget gpg git sudo coreutils apt-transport-https
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
RUN install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
RUN sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
RUN rm -f packages.microsoft.gpg
RUN apt update && apt install -y code

# Non root user
RUN useradd -rm -d /home/dev -s /bin/bash -g root -G sudo -u 1000 -p "dev" dev
RUN echo "dev ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/dev
USER dev
WORKDIR /usr/src/app
