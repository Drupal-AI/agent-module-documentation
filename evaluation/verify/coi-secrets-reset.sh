#!/usr/bin/env bash
# Execution RESET: set coi.settings overridden_value.secrets to the default FALSE so verify
# FAILS until the agent enables exposing secret overridden values. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set coi.settings overridden_value.secrets 0 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: coi.settings overridden_value.secrets=false"
