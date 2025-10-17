FROM debian-trixie-xfce-xrdp

ENV DEBIAN_FRONTEND=noninteractive

# Install Node.js and npm from Debian (initial version)
RUN apt-get update && \
    apt-get install -y --no-install-recommends nodejs npm curl && \
    rm -rf /var/lib/apt/lists/*

# Install 'n' globally via npm and upgrade Node.js
RUN npm install -g n && \
    n 18 && \
    apt-get purge -y nodejs npm && \
    ln -sf /usr/local/n/versions/node/18.*/bin/node /usr/bin/node && \
    ln -sf /usr/local/n/versions/node/18.*/bin/npm /usr/bin/npm

# Copy setup scripts
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY start-xrdp.sh /usr/local/bin/start-xrdp.sh
COPY fix-permissions.sh /usr/local/bin/fix-permissions.sh
COPY keyboard-layout.sh /usr/local/bin/keyboard-layout.sh
COPY password.sh /usr/local/bin/password.sh

# Make them executable
RUN chmod +x /usr/local/bin/*.sh

# Delegate startup to entrypoint
CMD ["/usr/local/bin/entrypoint.sh"]
