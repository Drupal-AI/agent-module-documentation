#!/usr/bin/env bash
# Execution VERIFY: PASS when a field storage node.field_dim_area of type area_field_type is
# attached to the article bundle. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node", "field_dim_area");
  $fc = FieldConfig::loadByName("node", "article", "field_dim_area");
  $ok = ($fs && $fs->getType() === "area_field_type" && $fc);
  print ($ok ? "PASS" : "FAIL") . " type=" . ($fs ? $fs->getType() : "none") . " attached=" . ($fc ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
