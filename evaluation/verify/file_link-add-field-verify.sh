#!/usr/bin/env bash
# Execution VERIFY: PASS when Article has a field field_flink_task whose field-type is file_link.
# Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  $fs = FieldStorageConfig::loadByName("node", "field_flink_task");
  $type = $fs ? $fs->getType() : "none";
  $ok = ($fs && $type === "file_link");
  print ($ok ? "PASS" : "FAIL") . " field_type=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
