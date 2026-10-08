#!/usr/bin/env bash
# Execution CLEANUP: clear protected_urls and delete the probe nodes, user and role.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  \Drupal::configFactory()->getEditable("prevent_homepage_deletion.settings")
    ->set("protected_urls", "")->save();
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  foreach (["PHD Task Page", "PHD Control Page"] as $title) {
    foreach ($storage->loadByProperties(["title" => $title]) as $node) { $node->delete(); }
  }
  if ($user = user_load_by_name("phd_task_user")) { $user->delete(); }
  if ($role = Role::load("phd_task_editor")) { $role->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: PHD task fixtures removed and protected_urls cleared"
