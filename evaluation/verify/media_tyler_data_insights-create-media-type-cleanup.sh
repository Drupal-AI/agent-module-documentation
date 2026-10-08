#!/usr/bin/env bash
# Execution CLEANUP: delete any media type sourced by media_tylerdi and its source field. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  foreach (MediaType::loadMultiple() as $mt) {
    if ($mt->getSource()->getPluginId() === "media_tylerdi") {
      $fn = $mt->getSource()->getSourceFieldDefinition($mt)?->getName() ?? ($mt->getSource()->getConfiguration()["source_field"] ?? NULL);
      $mt->delete();
      if ($fn) {
        if ($fc = FieldConfig::loadByName("media", $mt->id(), $fn)) { $fc->delete(); }
        if ($fs = FieldStorageConfig::loadByName("media", $fn)) { $fs->delete(); }
      }
    }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: removed any media type using media_tylerdi"
