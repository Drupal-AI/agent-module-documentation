#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("response_header");
  if ($e = $s->load("hrh_med_value")) { $e->delete(); }
' >/dev/null 2>&1
echo "cleanup: removed hrh_med_value"
