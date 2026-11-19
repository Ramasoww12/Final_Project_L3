#!/bin/bash

apt-get update -y

apt-get install -y nginx stress-ng

cat <<'EOF' > /var/www/html/index.html
${html_content}
EOF

systemctl enable nginx
systemctl restart nginx