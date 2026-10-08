#!/usr/bin/env bash
# Execution CLEANUP: delete the lm_bulk_editor role.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("user_role");
  foreach (["lm_bulk_editor"] as $rid) { if ($r = $storage->load($rid)) { $r->delete(); } }
' >/dev/null 2>&1
echo "cleanup: role lm_bulk_editor removed"
