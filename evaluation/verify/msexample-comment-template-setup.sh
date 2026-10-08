#!/usr/bin/env bash
# Introspection SETUP (message_subscribe_example): enable the example submodule so its message
# templates + hook behavior are live for the agent to inspect (which template a new comment uses).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush -y en message_subscribe_example >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: message_subscribe_example enabled (message templates incl. create_comment present)"
