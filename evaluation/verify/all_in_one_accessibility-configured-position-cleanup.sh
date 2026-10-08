#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("all_in_one_accessibility.userid.settings")->delete();' >/dev/null 2>&1
echo "cleanup: all_in_one_accessibility.userid.settings deleted (baseline: unsaved)"
