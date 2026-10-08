#!/usr/bin/env bash
# Execution VERIFY: PASS when a fivestar field field_fs_task exists on Article (storage type
# 'fivestar' + a field instance on the article bundle). Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node", "field_fs_task");
  $fc = FieldConfig::loadByName("node", "article", "field_fs_task");
  $type = $fs ? $fs->getType() : "none";
  $ok = ($fs && $fc && $type === "fivestar");
  print ($ok ? "PASS" : "FAIL") . " storage_type=" . $type . " instance=" . ($fc ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
