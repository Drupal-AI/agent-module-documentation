#!/usr/bin/env bash
# Execution CLEANUP: delete the memberships, group node, user, group registration and node type
# used by the og_ui permission case. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\og\Og;
  $membership_storage = \Drupal::entityTypeManager()->getStorage("og_membership");
  $ids = $membership_storage->getQuery()->accessCheck(FALSE)
    ->condition("entity_type", "node")
    ->condition("entity_bundle", "ogui_tgrp")
    ->execute();
  if ($ids) { $membership_storage->delete($membership_storage->loadMultiple($ids)); }
  if (Og::isGroup("node", "ogui_tgrp")) { Og::groupTypeManager()->removeGroup("node", "ogui_tgrp"); }
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  foreach ($storage->loadByProperties(["type" => "ogui_tgrp"]) as $node) { $node->delete(); }
  if ($nt = NodeType::load("ogui_tgrp")) { $nt->delete(); }
  if ($user = user_load_by_name("ogui_task_user")) { $user->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: og_ui permission fixtures removed"
