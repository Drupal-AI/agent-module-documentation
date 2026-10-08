#!/usr/bin/env bash
# Execution CLEANUP: clear protected_urls, delete the locked node, the user and the role.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  \Drupal::configFactory()->getEditable("prevent_homepage_deletion.settings")
    ->set("protected_urls", "")->save();
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "PHD Locked Page"]) as $node) {
    $node->delete();
  }
  if ($user = user_load_by_name("phd_lock_user")) { $user->delete(); }
  if ($role = Role::load("phd_lock_admin")) { $role->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: PHD lock fixtures removed and protected_urls cleared"
