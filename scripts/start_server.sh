#!/bin/bash
set -e

# Create systemd service (idempotent)
SERVICE_FILE=/etc/systemd/system/nodeapp.service

if [ ! -f "$SERVICE_FILE" ]; then
  cat >/tmp/nodeapp.service <<'EOF'
[Unit]
Description=Node.js App
After=network.target

[Service]
User=ubuntu
WorkingDirectory=/opt/app/current
ExecStart=/usr/bin/node /opt/app/current/server.js
Restart=always
Environment=PORT=4000

[Install]
WantedBy=multi-user.target
EOF
  sudo mv /tmp/nodeapp.service $SERVICE_FILE
  sudo chmod 644 $SERVICE_FILE
  sudo systemctl daemon-reload
  sudo systemctl enable nodeapp
fi

sudo systemctl restart nodeapp
