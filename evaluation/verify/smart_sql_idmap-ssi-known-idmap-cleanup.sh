#!/usr/bin/env bash
# Introspection CLEANUP: remove the ssi_known migration config entity. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("migration");
  if ($e = $s->load("ssi_known")) { $e->delete(); }
' >/dev/null 2>&1
echo "cleanup: ssi_known removed"
