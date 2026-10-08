#!/usr/bin/env bash
# Execution CLEANUP: remove field_dxprb_body from Article (drops its view-display component too).
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  \Drupal::entityTypeManager()->getStorage("field_config")->resetCache();
  if ($fc = FieldConfig::loadByName("node", "article", "field_dxprb_body")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_dxprb_body")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_dxprb_body removed from node.article"
