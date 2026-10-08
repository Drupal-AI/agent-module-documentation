#!/usr/bin/env bash
# Introspection SETUP: ensure automated_cron is enabled and set automated_cron.settings:interval
# to a distinctive 86400, so the cron settings form's 'Run cron every' field carries a
# config_override_core_fields #config hint the agent must read back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:install automated_cron -y >/dev/null 2>&1 || true
drush config:set automated_cron.settings interval 86400 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: automated_cron enabled, automated_cron.settings:interval=86400"
