#!/usr/bin/env bash
# Introspection CLEANUP: remove ssi_plain and ssi_smart. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("migration");
  foreach (["ssi_plain","ssi_smart"] as $id) { if ($e = $s->load($id)) { $e->delete(); } }
' >/dev/null 2>&1
echo "cleanup: ssi_plain + ssi_smart removed"
