FROM debian-trixie-xfce-xrdp

ENV DEBIAN_FRONTEND=noninteractive

# Install Python and Node.js
RUN apt update && apt install -y \
    python3 python3-pip \
    nodejs npm \
    && apt clean
