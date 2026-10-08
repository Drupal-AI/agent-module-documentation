#!/usr/bin/env bash
# Execution RESET: force sidebar_width=30 and automatic_preview=false (shipped defaults) so the
# verify FAILS until the agent sets the requested values. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("frontend_editing.settings")
    ->set("sidebar_width", 30)->set("automatic_preview", FALSE)->save();
' >/dev/null 2>&1
echo "reset: sidebar_width=30 automatic_preview=false"
