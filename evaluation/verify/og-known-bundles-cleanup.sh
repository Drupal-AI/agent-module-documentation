#!/usr/bin/env bash
# Introspection CLEANUP: remove the OG group registration, the og_audience field and the three
# probe node types (deleting their nodes first). Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\og\Og;
  if (Og::isGroup("node", "og_grp")) { Og::groupTypeManager()->removeGroup("node", "og_grp"); }
  if ($fc = FieldConfig::loadByName("node", "og_gcontent", "og_audience")) { $fc->delete(); }
  if (($fs = FieldStorageConfig::loadByName("node", "og_audience")) && !$fs->getBundles()) { $fs->delete(); }
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  foreach (["og_grp", "og_gcontent", "og_plain"] as $type) {
    foreach ($storage->loadByProperties(["type" => $type]) as $node) { $node->delete(); }
    if ($nt = NodeType::load($type)) { $nt->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: og_grp/og_gcontent/og_plain node types and the og_audience field removed"
