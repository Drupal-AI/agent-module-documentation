#!/usr/bin/env bash
# Execution CLEANUP: clear pages_restriction mapping back to empty. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("pages_restriction.settings");
  $c->set("pages_restriction", "")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: pages_restriction mapping cleared"
