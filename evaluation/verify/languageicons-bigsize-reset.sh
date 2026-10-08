#!/usr/bin/env bash
# Execution RESET: force languageicons size to the default 16x12 so verify FAILS until the
# agent sets a larger custom size (32x24). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set languageicons.settings size 16x12 -y >/dev/null 2>&1
echo "reset: languageicons.settings size=16x12"
