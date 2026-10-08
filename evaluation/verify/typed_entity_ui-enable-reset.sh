#!/usr/bin/env bash
# Execution RESET: uninstall typed_entity_ui so verify FAILS until the agent enables it.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu typed_entity_ui -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: typed_entity_ui uninstalled"
