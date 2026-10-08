#!/usr/bin/env bash
# Execution RESET: set coi.settings override_behavior to the default 'disable' so verify FAILS
# until the agent changes it to 'noaccess'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set coi.settings override_behavior disable -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: coi.settings override_behavior=disable"
