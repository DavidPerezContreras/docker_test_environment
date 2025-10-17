FROM debian-trixie-xfce-xrdp

ENV DEBIAN_FRONTEND=noninteractive

# Copy all setup scripts
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY start-xrdp.sh /usr/local/bin/start-xrdp.sh
COPY fix-permissions.sh /usr/local/bin/fix-permissions.sh
COPY keyboard-layout.sh /usr/local/bin/keyboard-layout.sh

# Make them executable
RUN chmod +x /usr/local/bin/entrypoint.sh \
    && chmod +x /usr/local/bin/start-xrdp.sh \
    && chmod +x /usr/local/bin/fix-permissions.sh \
    && chmod +x /usr/local/bin/keyboard-layout.sh

# Delegate startup to entrypoint
CMD ["/usr/local/bin/entrypoint.sh"]
