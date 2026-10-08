#!/usr/bin/env bash
# Execution RESET: uninstall imageapi_optimize_webp_responsive so verify FAILS until re-enabled.
set -uo pipefail
cd /var/www/html
drush pmu imageapi_optimize_webp_responsive -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: imageapi_optimize_webp_responsive uninstalled"
