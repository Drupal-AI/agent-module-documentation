#!/usr/bin/env bash
# Execution RESET: build a real OG group type ogui_tgrp with a group node "OG UI Task Club" and
# an ACTIVE member ogui_task_user holding only the required member role, then make sure the
# member role does NOT have the group permission 'manage members' - so verify FAILS.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  use Drupal\node\Entity\NodeType;
  use Drupal\user\Entity\User;
  use Drupal\og\Og;
  use Drupal\og\Entity\OgRole;
  if (!NodeType::load("ogui_tgrp")) { NodeType::create(["type" => "ogui_tgrp", "name" => "OG UI Task Group"])->save(); }
  if (!Og::isGroup("node", "ogui_tgrp")) { Og::groupTypeManager()->addGroup("node", "ogui_tgrp"); }
  $role = OgRole::load("node-ogui_tgrp-member");
  $role->revokePermission("manage members");
  $role->save();
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  $found = $storage->loadByProperties(["title" => "OG UI Task Club"]);
  // Owner must NOT be user 1 and group_manager_full_access must not mask the permission check.
  $group = $found ? reset($found) : Node::create(["type" => "ogui_tgrp", "title" => "OG UI Task Club", "uid" => 0]);
  $group->setPublished()->save();
  $user = user_load_by_name("ogui_task_user");
  if (!$user) {
    $user = User::create(["name" => "ogui_task_user", "mail" => "ogui_task_user@example.com", "status" => 1]);
    $user->save();
  }
  $membership_storage = \Drupal::entityTypeManager()->getStorage("og_membership");
  $ids = $membership_storage->getQuery()->accessCheck(FALSE)
    ->condition("entity_type", "node")
    ->condition("entity_bundle", "ogui_tgrp")
    ->execute();
  if ($ids) { $membership_storage->delete($membership_storage->loadMultiple($ids)); }
  Og::createMembership($group, $user)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ogui_tgrp group ready; node-ogui_tgrp-member lacks 'manage members'"
