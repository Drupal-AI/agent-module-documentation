#!/usr/bin/env bash
# Execution CLEANUP: restore shipped default kill_switch=false. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("media_alias_display.settings")->set("kill_switch", FALSE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: kill_switch restored to false"
