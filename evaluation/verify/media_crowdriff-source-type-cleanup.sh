#!/usr/bin/env bash
# Introspection CLEANUP: remove media type mc_probe_type and its Crowdriff source field.
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  if ($fc = FieldConfig::loadByName("media","mc_probe_type","field_media_media_crowdriff")) { $fc->delete(); }
  if ($t = MediaType::load("mc_probe_type")) { $t->delete(); }
  // Drop the shared source-field storage only if no media bundle still uses it.
  if ($fs = FieldStorageConfig::loadByName("media","field_media_media_crowdriff")) {
    if (count($fs->getBundles()) === 0) { $fs->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: mc_probe_type removed"
