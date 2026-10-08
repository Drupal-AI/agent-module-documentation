#!/usr/bin/env bash
# Execution VERIFY: PASS when a key_value (or key_value_long) field named field_kvf_task exists
# with a storage of the correct type AND is attached to the Article bundle. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node", "field_kvf_task");
  $fc = FieldConfig::loadByName("node", "article", "field_kvf_task");
  $type = $fs ? $fs->getType() : "none";
  $ok = $fs && $fc && in_array($type, ["key_value", "key_value_long"], TRUE);
  print ($ok ? "PASS" : "FAIL") . " storage_type=" . $type . " on_article=" . var_export((bool) $fc, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
