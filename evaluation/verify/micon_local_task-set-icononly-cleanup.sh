#!/usr/bin/env bash
# Execution CLEANUP: restore shipped default icon_only = false. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("micon_local_task.config")->set("icon_only", FALSE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: micon_local_task.config icon_only=false (default)"
