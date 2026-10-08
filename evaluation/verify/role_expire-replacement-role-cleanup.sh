#!/usr/bin/env bash
# Execution CLEANUP: clear the replacement mapping and delete roles re_task and re_after.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  \Drupal::configFactory()->getEditable("role_expire.config")->set("role_expire_default_roles", "")->save();
  foreach (["re_task", "re_after"] as $rid) { if ($r = Role::load($rid)) { $r->delete(); } }
' >/dev/null 2>&1
echo "cleanup: re_task and re_after roles removed, replacement mapping cleared"
