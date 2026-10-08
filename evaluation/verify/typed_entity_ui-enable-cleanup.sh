#!/usr/bin/env bash
# Execution CLEANUP: uninstall typed_entity_ui to restore baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu typed_entity_ui -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: typed_entity_ui uninstalled"
