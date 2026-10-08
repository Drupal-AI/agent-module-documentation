#!/usr/bin/env bash
# Execution RESET: build a real OG group (node type og_agrp registered as a group, group node
# "OG Task Club") and a user og_task_member, then delete EVERY membership that user has in the
# group - so verify FAILS until the agent creates the membership. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  use Drupal\node\Entity\NodeType;
  use Drupal\user\Entity\User;
  use Drupal\og\Og;
  if (!NodeType::load("og_agrp")) { NodeType::create(["type" => "og_agrp", "name" => "OG Add Member Group"])->save(); }
  if (!Og::isGroup("node", "og_agrp")) { Og::groupTypeManager()->addGroup("node", "og_agrp"); }
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  $found = $storage->loadByProperties(["title" => "OG Task Club"]);
  $group = $found ? reset($found) : Node::create(["type" => "og_agrp", "title" => "OG Task Club", "uid" => 1]);
  $group->setPublished()->save();
  $user = user_load_by_name("og_task_member");
  if (!$user) {
    $user = User::create(["name" => "og_task_member", "mail" => "og_task_member@example.com", "status" => 1]);
    $user->save();
  }
  $membership_storage = \Drupal::entityTypeManager()->getStorage("og_membership");
  $ids = $membership_storage->getQuery()->accessCheck(FALSE)
    ->condition("entity_type", "node")
    ->condition("entity_bundle", "og_agrp")
    ->execute();
  if ($ids) { $membership_storage->delete($membership_storage->loadMultiple($ids)); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: group 'OG Task Club' (node type og_agrp) exists; og_task_member has no membership"
