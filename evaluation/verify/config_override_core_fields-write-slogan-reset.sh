#!/usr/bin/env bash
# Execution RESET: clear the site slogan (system.site:slogan = '') so verify FAILS until the
# agent sets it via the config object/key the Slogan field maps to. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set system.site slogan '' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: system.site:slogan cleared"
