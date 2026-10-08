#!/usr/bin/env bash
# Introspection CLEANUP: remove the audience field, the group registration and both probe node
# types (deleting their nodes and memberships first). Restores baseline. Idempotent. Exit 0.
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
    ->condition("entity_bundle", "ogp_grp")
    ->execute();
  if ($ids) { $membership_storage->delete($membership_storage->loadMultiple($ids)); }
  if ($fc = FieldConfig::loadByName("node", "ogp_content", "og_audience")) { $fc->delete(); }
  if (($fs = FieldStorageConfig::loadByName("node", "og_audience")) && !$fs->getBundles()) { $fs->delete(); }
  if (Og::isGroup("node", "ogp_grp")) { Og::groupTypeManager()->removeGroup("node", "ogp_grp"); }
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  foreach (["ogp_grp", "ogp_content"] as $type) {
    foreach ($storage->loadByProperties(["type" => $type]) as $node) { $node->delete(); }
    if ($nt = NodeType::load($type)) { $nt->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ogp_grp / ogp_content and the og_audience field removed"
