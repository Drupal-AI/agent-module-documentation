#!/usr/bin/env bash
# Execution CLEANUP: identical to reset — remove the mfe_caps_demo module and its dir.
# pmu BEFORE deleting the directory (an enabled module with no dir makes the kernel fatal).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu mfe_caps_demo -y >/dev/null 2>&1 || true
rm -rf /var/www/html/web/modules/custom/mfe_caps_demo
drush cr >/dev/null 2>&1
echo "reset: mfe_caps_demo uninstalled and directory removed"
