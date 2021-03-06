#!/bin/bash
# Install V2Ray
curl https://raw.githubusercontent.com/v2ray/v2ray-core/01365e92d258bf31a5966483134036dd2a030398/release/install-release.sh | bash
# Remove extra functions
rm -rf /usr/bin/v2ray/geosite.dat /usr/bin/v2ray/geoip.dat
# V2Ray new configuration
cat <<-EOF > /etc/v2ray/config.json
{
  "inbounds": [
  {
    "port": ${PORT},
    "protocol": "vmess",
    "settings": {
      "clients": [
        {
          "id": "${UUID}",
          "alterId": 64
        }
      ]
    },
    "streamSettings": {
      "network": "ws"
    }
  }
  ],
  "outbounds": [
  {
    "protocol": "freedom",
    "settings": {
      "domainStrategy": "UseIP"
    }
  }
  ],
  "dns": {
      "servers": [
          "https+local://1.1.1.1/dns-query",
          "1.1.1.1",
          "8.8.8.8",
          "localhost"
      ]
  }
}
EOF
/usr/bin/v2ray/v2ray -config=/etc/v2ray/config.json
