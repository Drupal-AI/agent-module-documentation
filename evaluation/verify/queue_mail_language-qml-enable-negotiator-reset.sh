#!/usr/bin/env bash
# Execution RESET: uninstall queue_mail_language so its language negotiator service is gone
# and verify FAILS until the agent enables the submodule.
set -uo pipefail
cd /var/www/html
if drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx queue_mail_language; then
  drush pmu queue_mail_language -y >/dev/null 2>&1
fi
drush cr >/dev/null 2>&1
echo "reset: queue_mail_language uninstalled (negotiator service absent)"
