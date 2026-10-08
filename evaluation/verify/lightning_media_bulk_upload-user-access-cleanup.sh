#!/usr/bin/env bash
# Execution CLEANUP: delete the lm_bulk_user account and the lm_bulk_team role.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("user")->loadByProperties(["name" => "lm_bulk_user"]) as $u) { $u->delete(); }
  $storage = \Drupal::entityTypeManager()->getStorage("user_role");
  foreach (["lm_bulk_team"] as $rid) { if ($r = $storage->load($rid)) { $r->delete(); } }
' >/dev/null 2>&1
echo "cleanup: user lm_bulk_user and role lm_bulk_team removed"
