#!/usr/bin/env bash
# Execution RESET: force languageicons placement to the default "before" so verify FAILS
# until the agent changes it to "replace" (flag only). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set languageicons.settings placement before -y >/dev/null 2>&1
echo "reset: languageicons.settings placement=before"
