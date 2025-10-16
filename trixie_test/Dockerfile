FROM debian:trixie

ENV DEBIAN_FRONTEND=noninteractive

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

EXPOSE 3389

CMD ["/bin/bash", "-c", "/usr/sbin/xrdp-sesman && /usr/sbin/xrdp && tail -f /dev/null"]
