#!/usr/bin/env bash
# Execution CLEANUP: delete the rate_ro widget. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $w = \Drupal::entityTypeManager()->getStorage("rate_widget")->load("rate_ro");
  if ($w) { $w->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: rate_widget rate_ro removed"
