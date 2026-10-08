#!/usr/bin/env bash
# Introspection CLEANUP: delete both roles created by the matching setup.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("user_role");
  foreach (["lm_bulk_partial", "lm_bulk_full"] as $rid) { if ($r = $storage->load($rid)) { $r->delete(); } }
' >/dev/null 2>&1
echo "cleanup: roles lm_bulk_partial and lm_bulk_full removed"
