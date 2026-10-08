#!/usr/bin/env bash
# Execution RESET: force printable.settings.page_orientation to the default Portrait so verify
# FAILS until the agent switches it to Landscape. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset printable.settings page_orientation Portrait -y >/dev/null 2>&1
echo "reset: printable.settings page_orientation = Portrait"
