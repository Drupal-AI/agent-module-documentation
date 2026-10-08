#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped placeholder default for paths. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("admin_theme.settings")->set("paths", "/dummy-path-needed-until-core-issue-2930364-is-fixed")->save();
' >/dev/null 2>&1
echo "cleanup: admin_theme.settings paths restored to placeholder default"
