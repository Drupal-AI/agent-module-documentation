#!/usr/bin/env bash
# Execution RESET: ensure pcb_redis is INSTALLED so the permanent redis service is present and
# verify FAILS until the agent uninstalls it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en pcb_redis -y >/dev/null 2>&1
echo "reset: pcb_redis installed (service present)"
