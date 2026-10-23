#!/bin/bash

set -euo pipefail

SSHD_CONFIG_DIR=/etc/ssh/sshd_config.d
SSHD_PASSWORD_AUTH="$SSHD_CONFIG_DIR/01-password-auth.conf"

if sshd -T | grep -i '^passwordauthentication yes' >/dev/null; then
  :
elif [ ! -f "$SSHD_PASSWORD_AUTH" ]; then
  mkdir -p "$SSHD_CONFIG_DIR"

  echo "PasswordAuthentication yes" >"$SSHD_PASSWORD_AUTH"

  chmod 644 "$SSHD_PASSWORD_AUTH"

  if ! sshd -t; then
    echo "sshd -t: error in /etc/ssh/sshd_config.d, resetting $SSHD_PASSWORD_AUTH" >&2
    rm -f "$SSHD_PASSWORD_AUTH"
    exit 1
  fi

  systemctl restart ssh
fi

echo "PasswordAuthentication: $(sshd -T | grep -i '^passwordauthentication')"
