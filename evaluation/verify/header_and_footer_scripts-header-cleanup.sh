#!/usr/bin/env bash
# Execution CLEANUP: clear all three region configs (restore baseline). Exit 0.
# empty state. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (["header", "body", "footer"] as $r) {
    \Drupal::configFactory()->getEditable("header_and_footer_scripts.$r.settings")->delete();
  }
' >/dev/null 2>&1
echo "cleanup: header/body/footer scripts configs cleared"
