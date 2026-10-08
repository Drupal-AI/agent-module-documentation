#!/usr/bin/env bash
# Execution RESET: delete the entire add_to_head.settings config object, so no profiles exist
# and the matching verify script FAILS until the agent creates the required profile.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:delete add_to_head.settings >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: add_to_head.settings deleted (no profiles)"
