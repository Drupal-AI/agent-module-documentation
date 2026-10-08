#!/usr/bin/env bash
# Execution RESET: delete the lm_bulk_user account and the lm_bulk_team role so verify FAILS
# on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("user")->loadByProperties(["name" => "lm_bulk_user"]) as $u) { $u->delete(); }
  $storage = \Drupal::entityTypeManager()->getStorage("user_role");
  foreach (["lm_bulk_team"] as $rid) { if ($r = $storage->load($rid)) { $r->delete(); } }
' >/dev/null 2>&1
echo "reset: user lm_bulk_user and role lm_bulk_team removed"
