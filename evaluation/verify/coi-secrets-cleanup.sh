#!/usr/bin/env bash
# Execution CLEANUP: restore coi.settings overridden_value.secrets to default FALSE. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set coi.settings overridden_value.secrets 0 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: coi.settings overridden_value.secrets restored to false"
