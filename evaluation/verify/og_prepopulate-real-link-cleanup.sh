#!/usr/bin/env bash
# Execution CLEANUP: delete the menu link, memberships, group node, audience field, group
# registration and both node types. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\og\Og;
  foreach (\Drupal::entityTypeManager()->getStorage("menu_link_content")->loadByProperties(["title" => "OG Prepopulate Eval Link"]) as $link) {
    $link->delete();
  }
  $membership_storage = \Drupal::entityTypeManager()->getStorage("og_membership");
  $ids = $membership_storage->getQuery()->accessCheck(FALSE)
    ->condition("entity_type", "node")
    ->condition("entity_bundle", "ogp_lgrp")
    ->execute();
  if ($ids) { $membership_storage->delete($membership_storage->loadMultiple($ids)); }
  if ($fc = FieldConfig::loadByName("node", "ogp_lcontent", "og_audience")) { $fc->delete(); }
  if (($fs = FieldStorageConfig::loadByName("node", "og_audience")) && !$fs->getBundles()) { $fs->delete(); }
  if (Og::isGroup("node", "ogp_lgrp")) { Og::groupTypeManager()->removeGroup("node", "ogp_lgrp"); }
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  foreach (["ogp_lgrp", "ogp_lcontent"] as $type) {
    foreach ($storage->loadByProperties(["type" => $type]) as $node) { $node->delete(); }
    if ($nt = NodeType::load($type)) { $nt->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: OGP link fixtures removed"
