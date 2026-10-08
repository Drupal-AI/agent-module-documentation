#!/usr/bin/env bash
# Execution RESET: create/refresh two Articles ("PHD Task Page" and "PHD Control Page"), a role
# phd_task_editor that may delete any article but has NO delete_homepage_node, and a user
# phd_task_user in that role - then CLEAR protected_urls so both nodes are deletable and verify
# FAILS. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  use Drupal\user\Entity\Role;
  use Drupal\user\Entity\User;
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  foreach (["PHD Task Page", "PHD Control Page"] as $title) {
    $found = $storage->loadByProperties(["title" => $title]);
    $node = $found ? reset($found) : Node::create(["type" => "article", "title" => $title, "uid" => 1]);
    $node->setPublished()->save();
  }
  $role = Role::load("phd_task_editor") ?: Role::create(["id" => "phd_task_editor", "label" => "PHD Task Editor"]);
  $role->grantPermission("access content");
  $role->grantPermission("delete any article content");
  $role->revokePermission("delete_homepage_node");
  $role->save();
  $user = user_load_by_name("phd_task_user");
  if (!$user) {
    $user = User::create(["name" => "phd_task_user", "mail" => "phd_task_user@example.com", "status" => 1]);
  }
  $user->addRole("phd_task_editor");
  $user->save();
  \Drupal::configFactory()->getEditable("prevent_homepage_deletion.settings")
    ->set("protected_urls", "")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: PHD Task/Control pages + phd_task_user created; protected_urls cleared"
