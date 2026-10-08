#!/usr/bin/env bash
# Execution RESET: remove any dhv_login_override module (uninstall BEFORE deleting its dir to
# avoid an orphaned enabled module), leaving the login form with novalidate present so verify
# fails on empty state. Idempotent.
set -uo pipefail
cd /var/www/html
if drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx dhv_login_override; then
  drush pmu dhv_login_override -y >/dev/null 2>&1 || true
fi
rm -rf web/modules/custom/dhv_login_override
drush cr >/dev/null 2>&1
echo "reset: dhv_login_override absent; login form still has novalidate"
