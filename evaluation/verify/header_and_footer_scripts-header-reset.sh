#!/usr/bin/env bash
# Execution RESET: clear all three header_and_footer_scripts region configs so verify FAILS on
# empty state. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (["header", "body", "footer"] as $r) {
    \Drupal::configFactory()->getEditable("header_and_footer_scripts.$r.settings")->delete();
  }
' >/dev/null 2>&1
echo "reset: header/body/footer scripts configs cleared"
