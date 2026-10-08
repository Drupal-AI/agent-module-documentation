#!/usr/bin/env bash
# Introspection CLEANUP (daterange_compact): remove format dc_known. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("daterange_compact_format");
  if ($e = $s->load("dc_known")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: dc_known removed"
