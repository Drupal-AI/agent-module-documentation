#!/usr/bin/env bash
# Execution CLEANUP: delete the memberships, the group node, the user, the group registration
# and the og_agrp node type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\og\Og;
  $membership_storage = \Drupal::entityTypeManager()->getStorage("og_membership");
  $ids = $membership_storage->getQuery()->accessCheck(FALSE)
    ->condition("entity_type", "node")
    ->condition("entity_bundle", "og_agrp")
    ->execute();
  if ($ids) { $membership_storage->delete($membership_storage->loadMultiple($ids)); }
  if (Og::isGroup("node", "og_agrp")) { Og::groupTypeManager()->removeGroup("node", "og_agrp"); }
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  foreach ($storage->loadByProperties(["type" => "og_agrp"]) as $node) { $node->delete(); }
  if ($nt = NodeType::load("og_agrp")) { $nt->delete(); }
  if ($user = user_load_by_name("og_task_member")) { $user->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: OG add-member fixtures removed"
