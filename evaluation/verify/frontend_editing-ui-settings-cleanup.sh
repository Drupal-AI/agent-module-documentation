#!/usr/bin/env bash
# Execution CLEANUP: restore shipped defaults sidebar_width=30 and automatic_preview=false.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("frontend_editing.settings")
    ->set("sidebar_width", 30)->set("automatic_preview", FALSE)->save();
' >/dev/null 2>&1
echo "cleanup: sidebar_width=30 automatic_preview=false"
