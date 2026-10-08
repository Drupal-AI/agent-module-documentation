#!/usr/bin/env bash
# Execution VERIFY: PASS when node.field_ccs_custom exists with type cs_custom_field and is
# attached to article. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node","field_ccs_custom");
  $fc = FieldConfig::loadByName("node","article","field_ccs_custom");
  $type = $fs ? $fs->getType() : NULL;
  $ok = ($fs && $fc && $type === "cs_custom_field");
  print ($ok ? "PASS" : "FAIL") . " type=" . var_export($type, TRUE) . " attached=" . var_export((bool)$fc, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
