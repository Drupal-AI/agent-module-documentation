#!/usr/bin/env bash
# Shared CLEANUP for the single_datetime_range evals: delete every field_sdtr_* field storage
# (and its bundle instances) on node, then remove the sdt_range_eval content type. Only touches
# this submodule's own namespaced artifacts. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  // Delete the bundle first (cascades its field instances), then any orphaned field_sdtr_*
  // storages. This order is more reliable than removing fields then the type.
  if ($nt = NodeType::load("sdt_range_eval")) { $nt->delete(); }
  foreach (FieldStorageConfig::loadMultiple() as $fs) {
    if ($fs->getTargetEntityTypeId() === "node" && str_starts_with($fs->getName(), "field_sdtr_")) {
      foreach ($fs->getBundles() as $bundle => $label) {
        if ($fc = FieldConfig::loadByName("node", $bundle, $fs->getName())) { $fc->delete(); }
      }
      $fs->delete();
    }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_sdtr_* removed, sdt_range_eval content type removed"
