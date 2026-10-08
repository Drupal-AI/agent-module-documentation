#!/usr/bin/env bash
# Introspection SETUP: create a role (commerce_license_member) and an ACTIVE role-type
# commerce_license entity for user 1 that grants it, so an agent can inspect the live license
# and report its state / granted role. Idempotent. Exit 0.
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
  $license = $storage->create([
    "type" => "role", "state" => "active", "uid" => 1,
    "license_role" => "commerce_license_member",
    "expiration_type" => ["target_plugin_id" => "unlimited", "target_plugin_configuration" => []],
  ]);
  $license->save();
' >/dev/null 2>&1
echo "setup: active role-license granting commerce_license_member created for user 1"
