#!/usr/bin/env bash
# Introspection CLEANUP: delete the memberships, the group node, the probe user, the group
# registration and the og_mgrp node type. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\og\Og;
  $membership_storage = \Drupal::entityTypeManager()->getStorage("og_membership");
  $ids = $membership_storage->getQuery()->accessCheck(FALSE)
    ->condition("entity_type", "node")
    ->condition("entity_bundle", "og_mgrp")
    ->execute();
  if ($ids) { $membership_storage->delete($membership_storage->loadMultiple($ids)); }
  if (Og::isGroup("node", "og_mgrp")) { Og::groupTypeManager()->removeGroup("node", "og_mgrp"); }
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  foreach ($storage->loadByProperties(["type" => "og_mgrp"]) as $node) { $node->delete(); }
  if ($nt = NodeType::load("og_mgrp")) { $nt->delete(); }
  if ($user = user_load_by_name("og_probe_user")) { $user->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: OG membership probe fixtures removed"
