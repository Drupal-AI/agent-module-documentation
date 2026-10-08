#!/usr/bin/env bash
# Execution VERIFY: PASS when field_fis_task exists on node/article as an image_style field
# storage with a field instance on the Article bundle. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node","field_fis_task");
  $fc = FieldConfig::loadByName("node","article","field_fis_task");
  $type = $fs ? $fs->getType() : "none";
  $ok = ($fs && $fc && $type === "image_style");
  print ($ok ? "PASS" : "FAIL") . " storage_type=" . $type . " instance=" . ($fc ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
