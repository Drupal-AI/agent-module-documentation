#!/usr/bin/env bash
# Shared CLEANUP for the single_datetime family evals: delete every field_sdt_* field storage
# (and its bundle instances) on node, then remove the single_datetime_eval content type. Only
# touches this family's own namespaced artifacts. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (FieldStorageConfig::loadMultiple() as $fs) {
    if ($fs->getTargetEntityTypeId() === "node" && str_starts_with($fs->getName(), "field_sdt_")) {
      try {
        foreach (array_keys($fs->getBundles()) as $bundle) {
          if ($fc = FieldConfig::loadByName("node", $bundle, $fs->getName())) { $fc->delete(); }
        }
        $fs->delete();
      }
      catch (\Throwable $e) { /* keep going; leftover purged on cron */ }
    }
  }
  if ($nt = NodeType::load("single_datetime_eval")) {
    try { $nt->delete(); } catch (\Throwable $e) {}
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_sdt_* removed, single_datetime_eval content type removed"
