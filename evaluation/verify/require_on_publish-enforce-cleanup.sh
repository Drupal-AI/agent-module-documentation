#!/usr/bin/env bash
# Execution CLEANUP: remove field_rop_enf from Article and any stray check nodes. Restores baseline.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  foreach (["ROP enforce check pub", "ROP enforce check unpub"] as $t) {
    foreach ($storage->loadByProperties(["title" => $t]) as $n) { $n->delete(); }
  }
  if ($fc = FieldConfig::loadByName("node", "article", "field_rop_enf")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_rop_enf")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: field_rop_enf removed from node.article"
