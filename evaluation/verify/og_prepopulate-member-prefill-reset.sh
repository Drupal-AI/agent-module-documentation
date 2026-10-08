#!/usr/bin/env bash
# Execution RESET: build a real OG group type ogp_tgrp with the group node "OGP Task Group" and
# a user ogp_task_user who has NO membership in it - so og_prepopulate's Og::isMember() rule is
# false and verify FAILS. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en og_prepopulate -y >/dev/null 2>&1
drush php:eval '
  use Drupal\node\Entity\Node;
  use Drupal\node\Entity\NodeType;
  use Drupal\user\Entity\User;
  use Drupal\og\Og;
  use Drupal\og\OgGroupAudienceHelperInterface;
  foreach (["ogp_tgrp" => "OGP Task Group Type", "ogp_tcontent" => "OGP Task Group Content"] as $id => $label) {
    if (!NodeType::load($id)) { NodeType::create(["type" => $id, "name" => $label])->save(); }
  }
  if (!Og::isGroup("node", "ogp_tgrp")) { Og::groupTypeManager()->addGroup("node", "ogp_tgrp"); }
  Og::createField(OgGroupAudienceHelperInterface::DEFAULT_FIELD, "node", "ogp_tcontent");
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  $found = $storage->loadByProperties(["title" => "OGP Task Group"]);
  // uid 0 so the group-owner shortcut cannot mask the membership check.
  $group = $found ? reset($found) : Node::create(["type" => "ogp_tgrp", "title" => "OGP Task Group", "uid" => 0]);
  $group->setPublished()->save();
  $user = user_load_by_name("ogp_task_user");
  if (!$user) {
    $user = User::create(["name" => "ogp_task_user", "mail" => "ogp_task_user@example.com", "status" => 1]);
    $user->save();
  }
  $membership_storage = \Drupal::entityTypeManager()->getStorage("og_membership");
  $ids = $membership_storage->getQuery()->accessCheck(FALSE)
    ->condition("entity_type", "node")
    ->condition("entity_bundle", "ogp_tgrp")
    ->execute();
  if ($ids) { $membership_storage->delete($membership_storage->loadMultiple($ids)); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: group 'OGP Task Group' exists; ogp_task_user has no membership in it"
