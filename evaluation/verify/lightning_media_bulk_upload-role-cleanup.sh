#!/usr/bin/env bash
# Introspection CLEANUP: delete the role created by the matching setup.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("user_role");
  foreach (["lm_bulk_uploader"] as $rid) { if ($r = $storage->load($rid)) { $r->delete(); } }
' >/dev/null 2>&1
echo "cleanup: role lm_bulk_uploader removed"
