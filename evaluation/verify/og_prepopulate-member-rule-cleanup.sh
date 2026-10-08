#!/usr/bin/env bash
# Introspection CLEANUP: delete the memberships, both group nodes, the probe user, the group
# registration and the ogp_mgrp node type. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\og\Og;
  $membership_storage = \Drupal::entityTypeManager()->getStorage("og_membership");
  $ids = $membership_storage->getQuery()->accessCheck(FALSE)
    ->condition("entity_type", "node")
    ->condition("entity_bundle", "ogp_mgrp")
    ->execute();
  if ($ids) { $membership_storage->delete($membership_storage->loadMultiple($ids)); }
  if (Og::isGroup("node", "ogp_mgrp")) { Og::groupTypeManager()->removeGroup("node", "ogp_mgrp"); }
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  foreach ($storage->loadByProperties(["type" => "ogp_mgrp"]) as $node) { $node->delete(); }
  if ($nt = NodeType::load("ogp_mgrp")) { $nt->delete(); }
  if ($user = user_load_by_name("ogp_probe_user")) { $user->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: OGP membership probe fixtures removed"
