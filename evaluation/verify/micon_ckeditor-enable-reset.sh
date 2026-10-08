#!/usr/bin/env bash
# Execution RESET: uninstall micon_ckeditor so verify FAILs until the agent enables it. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall micon_ckeditor -y >/dev/null 2>&1 || true
drush cr >/dev/null 2>&1
echo "reset: micon_ckeditor uninstalled"
