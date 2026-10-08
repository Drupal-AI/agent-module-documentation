#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("riddle");
  if ($e = $s->load("ri_known")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: riddle ri_known removed"
