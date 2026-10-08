#!/usr/bin/env bash
# Execution RESET: uninstall cloudflarepurger so the 'cloudflare' purge purger is absent.
set -uo pipefail
cd /var/www/html
drush pmu cloudflarepurger -y >/dev/null 2>&1 || true
drush cr >/dev/null 2>&1
echo "reset: cloudflarepurger uninstalled"
