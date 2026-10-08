#!/usr/bin/env bash
# Execution CLEANUP: restore include paths to the shipped placeholder default. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("admin_theme.settings")->set("paths", "/dummy-path-needed-until-core-issue-2930364-is-fixed")->save();
' >/dev/null 2>&1
echo "cleanup: admin_theme.settings paths restored to placeholder default"
