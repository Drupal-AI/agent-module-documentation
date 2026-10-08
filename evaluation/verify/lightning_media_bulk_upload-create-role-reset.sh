#!/usr/bin/env bash
# Execution RESET: delete the lm_bulk_editor role so verify FAILS on empty state.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("user_role");
  foreach (["lm_bulk_editor"] as $rid) { if ($r = $storage->load($rid)) { $r->delete(); } }
' >/dev/null 2>&1
echo "reset: role lm_bulk_editor removed"
