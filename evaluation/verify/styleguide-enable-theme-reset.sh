#!/usr/bin/env bash
# Execution RESET: ensure the core 'stark' theme is UNINSTALLED so the styleguide.stark route
# does not exist, so verify FAILS until the agent enables the theme.
set -uo pipefail
cd /var/www/html
drush theme:uninstall stark -y >/dev/null 2>&1 || true
drush cr >/dev/null 2>&1
echo "reset: theme 'stark' uninstalled (styleguide.stark route absent)"
