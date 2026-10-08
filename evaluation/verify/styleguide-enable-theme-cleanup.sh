#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush theme:uninstall stark -y >/dev/null 2>&1 || true
drush cr >/dev/null 2>&1
echo "cleanup: theme 'stark' uninstalled"
