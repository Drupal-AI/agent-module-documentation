#!/usr/bin/env bash
# Execution CLEANUP: delete memberships, the group node, the user, the audience field, the
# group registration and both node types. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\og\Og;
  $membership_storage = \Drupal::entityTypeManager()->getStorage("og_membership");
  $ids = $membership_storage->getQuery()->accessCheck(FALSE)
    ->condition("entity_type", "node")
    ->condition("entity_bundle", "ogp_tgrp")
    ->execute();
  if ($ids) { $membership_storage->delete($membership_storage->loadMultiple($ids)); }
  if ($fc = FieldConfig::loadByName("node", "ogp_tcontent", "og_audience")) { $fc->delete(); }
  if (($fs = FieldStorageConfig::loadByName("node", "og_audience")) && !$fs->getBundles()) { $fs->delete(); }
  if (Og::isGroup("node", "ogp_tgrp")) { Og::groupTypeManager()->removeGroup("node", "ogp_tgrp"); }
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  foreach (["ogp_tgrp", "ogp_tcontent"] as $type) {
    foreach ($storage->loadByProperties(["type" => $type]) as $node) { $node->delete(); }
    if ($nt = NodeType::load($type)) { $nt->delete(); }
  }
  if ($user = user_load_by_name("ogp_task_user")) { $user->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: OGP prefill fixtures removed"
