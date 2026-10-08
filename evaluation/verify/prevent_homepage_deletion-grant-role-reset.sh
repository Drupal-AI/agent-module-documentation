#!/usr/bin/env bash
# Execution RESET: create an Article "PHD Locked Page", list its path in protected_urls, and
# create a role phd_lock_admin (may delete any article, but WITHOUT delete_homepage_node) with
# a user phd_lock_user in it - so that user is currently denied and verify FAILS.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  use Drupal\user\Entity\Role;
  use Drupal\user\Entity\User;
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  $found = $storage->loadByProperties(["title" => "PHD Locked Page"]);
  $node = $found ? reset($found) : Node::create(["type" => "article", "title" => "PHD Locked Page", "uid" => 1]);
  $node->setPublished()->save();
  \Drupal::configFactory()->getEditable("prevent_homepage_deletion.settings")
    ->set("protected_urls", "/node/" . $node->id())->save();
  $role = Role::load("phd_lock_admin") ?: Role::create(["id" => "phd_lock_admin", "label" => "PHD Lock Admin"]);
  $role->grantPermission("access content");
  $role->grantPermission("delete any article content");
  $role->revokePermission("delete_homepage_node");
  $role->save();
  $user = user_load_by_name("phd_lock_user");
  if (!$user) {
    $user = User::create(["name" => "phd_lock_user", "mail" => "phd_lock_user@example.com", "status" => 1]);
  }
  $user->addRole("phd_lock_admin");
  $user->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: 'PHD Locked Page' protected; role phd_lock_admin lacks delete_homepage_node"
