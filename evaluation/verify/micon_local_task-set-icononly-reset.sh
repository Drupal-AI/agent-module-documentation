#!/usr/bin/env bash
# Execution RESET: force micon_local_task icon_only = false (shipped default) so verify FAILs
# until the agent enables icon-only. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("micon_local_task.config")->set("icon_only", FALSE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: micon_local_task.config icon_only=false"
