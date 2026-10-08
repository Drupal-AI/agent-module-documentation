#!/usr/bin/env bash
# Execution RESET: ensure the two media reference fields the example's step-2 migration writes into
# (field_image_media, field_image2_media on Article) do NOT exist, so verify FAILS until the agent
# generates them. Only touches these two example-specific fields. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_image_media","field_image2_media"] as $fn) {
    if ($fc = FieldConfig::loadByName("node","article",$fn)) { $fc->delete(); }
    if ($fs = FieldStorageConfig::loadByName("node",$fn)) { $fs->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: article field_image_media / field_image2_media absent"
