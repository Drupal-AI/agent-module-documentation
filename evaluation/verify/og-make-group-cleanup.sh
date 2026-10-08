#!/usr/bin/env bash
# Execution CLEANUP: unregister the group, drop the audience field and delete both task node
# types (and their nodes). Idempotent. Exit 0.
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
    ->condition("entity_bundle", "og_task_group")
    ->execute();
  if ($ids) { $membership_storage->delete($membership_storage->loadMultiple($ids)); }
  if (Og::isGroup("node", "og_task_group")) { Og::groupTypeManager()->removeGroup("node", "og_task_group"); }
  foreach (\Drupal::service("og.group_audience_helper")->getAllGroupAudienceFields("node", "og_task_content") as $name => $definition) {
    if ($fc = FieldConfig::loadByName("node", "og_task_content", $name)) { $fc->delete(); }
  }
  if (($fs = FieldStorageConfig::loadByName("node", "og_audience")) && !$fs->getBundles()) { $fs->delete(); }
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  foreach (["og_task_group", "og_task_content"] as $type) {
    foreach ($storage->loadByProperties(["type" => $type]) as $node) { $node->delete(); }
    if ($nt = NodeType::load($type)) { $nt->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: og_task_group / og_task_content removed from OG and deleted"
