#!/usr/bin/env bash
# Execution CLEANUP: restore Kint settings to shipped defaults. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("kint.settings")
    ->set("rich_theme", "original.css")
    ->set("date_format", "[c]")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: kint.settings restored to defaults"
