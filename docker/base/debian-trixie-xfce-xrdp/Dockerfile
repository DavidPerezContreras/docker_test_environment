FROM debian:trixie

ENV DEBIAN_FRONTEND=noninteractive

# Install packages and configure XRDP and user
RUN apt update && apt install -y \
    xfce4 xfce4-goodies xrdp dbus-x11 lightdm sudo openssl \
 && echo "startxfce4" > /etc/skel/.xsession \
 && adduser --disabled-password --gecos "" docker \
 && echo "docker:docker" | chpasswd \
 && adduser docker sudo \
 && mkdir -p /etc/xrdp/keys \
 && openssl req -x509 -nodes -newkey rsa:2048 \
      -keyout /etc/xrdp/keys/xrdp.key \
      -out /etc/xrdp/keys/xrdp.crt \
      -days 365 \
      -subj "/CN=localhost" \
 && tee -a /etc/xrdp/xrdp.ini > /dev/null <<EOF
ssl_protocols=TLSv1.2,TLSv1.3
certificate=/etc/xrdp/keys/xrdp.crt
key_file=/etc/xrdp/keys/xrdp.key
EOF


# Expose XRDP port
EXPOSE 3389

