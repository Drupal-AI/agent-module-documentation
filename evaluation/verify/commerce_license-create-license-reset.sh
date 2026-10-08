#!/usr/bin/env bash
# Execution RESET: ensure the commerce_license_member role exists but NO role-license granting
# it exists, so verify FAILS until the agent creates one. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if (!Role::load("commerce_license_member")) {
    Role::create(["id" => "commerce_license_member", "label" => "Commerce License Member"])->save();
  }
  $storage = \Drupal::entityTypeManager()->getStorage("commerce_license");
  $ids = $storage->getQuery()->accessCheck(FALSE)->condition("type", "role")->execute();
  foreach ($storage->loadMultiple($ids) as $l) {
    if ($l->license_role->target_id === "commerce_license_member") { $l->delete(); }
  }
' >/dev/null 2>&1
echo "reset: role commerce_license_member exists, no granting license"
