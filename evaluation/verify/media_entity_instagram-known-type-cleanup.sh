#!/usr/bin/env bash
# Introspection CLEANUP: remove the known media type ig_known and its source field
# (config + storage), restoring baseline (it does not ship by default). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  if ($t = MediaType::load("ig_known")) { $t->delete(); }
  if ($fc = \Drupal\field\Entity\FieldConfig::loadByName("media", "ig_known", "field_media_oembed_instagram")) { $fc->delete(); }
  if ($fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("media", "field_media_oembed_instagram")) {
    try { $fs->delete(); } catch (\Exception $e) {}
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: media type ig_known removed"
