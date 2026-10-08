#!/usr/bin/env bash
# Introspection SETUP: ensure dblog is enabled and set dblog.settings:row_limit to a
# distinctive 12345, so the database-log 'row limit' field appears on the logging settings form
# with a config_override_core_fields #config hint the agent must read back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:install dblog -y >/dev/null 2>&1 || true
drush config:set dblog.settings row_limit 12345 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: dblog enabled, dblog.settings:row_limit=12345"
