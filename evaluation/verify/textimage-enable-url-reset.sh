#!/usr/bin/env bash
# Execution RESET: force Textimage direct URL generation OFF, so verify FAILS until the agent
# enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("textimage.settings")->set("url_generation.enabled", FALSE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: textimage.settings url_generation.enabled=false"
