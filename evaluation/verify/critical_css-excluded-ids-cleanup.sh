#!/usr/bin/env bash
# medium CLEANUP (critical_css): delete critical_css.settings. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("critical_css.settings")->delete();' >/dev/null 2>&1
echo "cleanup: critical_css.settings removed"
