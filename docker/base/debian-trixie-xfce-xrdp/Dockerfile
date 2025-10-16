FROM debian:trixie

ENV DEBIAN_FRONTEND=noninteractive

# Install required packages and configure user and XRDP
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
    && echo "ssl_protocols=TLSv1.2,TLSv1.3" >> /etc/xrdp/xrdp.ini \
    && echo "certificate=/etc/xrdp/keys/xrdp.crt" >> /etc/xrdp/xrdp.ini \
    && echo "key_file=/etc/xrdp/keys/xrdp.key" >> /etc/xrdp/xrdp.ini

# Copy scripts
COPY start-xrdp.sh /usr/local/bin/start-xrdp.sh
COPY fix-desktop-permissions.sh /usr/local/bin/fix-desktop-permissions.sh
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/start-xrdp.sh \
    && chmod +x /usr/local/bin/fix-desktop-permissions.sh \
    && chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 3389

# Run entrypoint which handles permissions and starts XRDP
CMD ["/usr/local/bin/entrypoint.sh"]
