#!/usr/bin/env bash
# Execution VERIFY: PASS when node field_gmf_task exists on Article with type google_map_field.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node", "field_gmf_task");
  $fc = FieldConfig::loadByName("node", "article", "field_gmf_task");
  $type = $fs ? $fs->getType() : "none";
  $ok = ($fs && $fc && $type === "google_map_field");
  print ($ok ? "PASS" : "FAIL") . " storage_type=" . $type . " instance=" . ($fc ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
