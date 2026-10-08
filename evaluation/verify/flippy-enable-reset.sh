#!/usr/bin/env bash
# Execution RESET: ensure Flippy is OFF for Article so verify FAILS until enabled. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("flippy.settings")->set("flippy_article", FALSE)->save();
' >/dev/null 2>&1
echo "reset: flippy_article = FALSE"
