#!/usr/bin/env bash
# Introspection SETUP: ensure message_notify_example (and its deps) are enabled so its shipped
# message template example_create_comment and its fields are present for inspection. Node-free.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en message_notify_example -y >/dev/null 2>&1 || true
echo "setup: message_notify_example enabled; template example_create_comment present"
