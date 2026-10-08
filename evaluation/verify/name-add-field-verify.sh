#!/usr/bin/env bash
# Execution VERIFY: PASS when a `name`-type field field_name_cth exists on the name_cth bundle
# (both FieldStorageConfig and FieldConfig). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node", "field_name_cth");
  $fc = FieldConfig::loadByName("node", "name_cth", "field_name_cth");
  $type = $fs ? $fs->getType() : "none";
  $ok = ($fs && $fc && $type === "name");
  print ($ok ? "PASS" : "FAIL") . " storage=" . ($fs ? "yes" : "no") . " field=" . ($fc ? "yes" : "no") . " type=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
