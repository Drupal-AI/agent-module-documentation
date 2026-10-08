#!/usr/bin/env bash
# Introspection CLEANUP: delete the optimizely_known project. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("optimizely");
  if ($p = $s->load("optimizely_known")) { $p->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: optimizely_known removed"
