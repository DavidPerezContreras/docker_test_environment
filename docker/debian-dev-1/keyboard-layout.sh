#!/bin/bash

echo "🌐 Configuring Spanish keyboard layout for XRDP and XFCE"

# Set XRDP login screen layout (Spanish layout code: 0000040A)
sed -i '/^keyboard_layout=/c\keyboard_layout=0x0000040A' /etc/xrdp/xrdp.ini || echo "keyboard_layout=0x0000040A" >> /etc/xrdp/xrdp.ini

# Create .xsession for XFCE session with Spanish layout
cat <<EOF > /home/docker/.xsession
setxkbmap -model pc105 -layout es
startxfce4
EOF
chmod 644 /home/docker/.xsession
chown docker:docker /home/docker/.xsession

# Configure XFCE default keyboard layout
mkdir -p /home/docker/.config/xfce4/xfconf/xfce-perchannel-xml
cat <<EOF > /home/docker/.config/xfce4/xfconf/xfce-perchannel-xml/keyboard-layout.xml
<?xml version="1.0" encoding="UTF-8"?>
<channel name="keyboard-layout" version="1.0">
  <property name="Default" type="empty">
    <property name="Layout" type="string" value="es"/>
    <property name="Model" type="string" value="pc105"/>
  </property>
</channel>
EOF
chown -R docker:docker /home/docker/.config
chmod -R 755 /home/docker/.config

echo "✅ Spanish layout applied"
