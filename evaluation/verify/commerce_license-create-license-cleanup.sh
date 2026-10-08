#!/usr/bin/env bash
# Execution CLEANUP: delete the role-license(s) granting commerce_license_member and the role.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $storage = \Drupal::entityTypeManager()->getStorage("commerce_license");
  $ids = $storage->getQuery()->accessCheck(FALSE)->condition("type", "role")->execute();
  foreach ($storage->loadMultiple($ids) as $l) {
    if ($l->license_role->target_id === "commerce_license_member") { $l->delete(); }
  }
  if ($r = Role::load("commerce_license_member")) { $r->delete(); }
' >/dev/null 2>&1
echo "cleanup: role-license fixture removed"
