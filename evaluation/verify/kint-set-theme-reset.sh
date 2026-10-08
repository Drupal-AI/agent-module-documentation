#!/usr/bin/env bash
# Execution RESET: force Kint settings to shipped defaults so verify FAILS until the agent sets
# the Aante dark theme + date format. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("kint.settings")
    ->set("rich_theme", "original.css")
    ->set("date_format", "[c]")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: kint.settings at defaults (rich_theme=original.css, date_format=[c])"
