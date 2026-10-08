#!/usr/bin/env bash
# Execution RESET/CLEANUP: clear pwa.config name/short_name (shipped default '') so verify FAILS
# until the agent sets them. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("pwa.config")->set("name","")->set("short_name","")->save();' >/dev/null 2>&1
echo "reset: pwa.config name='' short_name='' (defaults)"
