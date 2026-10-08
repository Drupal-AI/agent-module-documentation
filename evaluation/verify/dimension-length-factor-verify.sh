#!/usr/bin/env bash
# Execution VERIFY: PASS when a length_field_type field node.article.field_dim_length exists AND
# its Length component factor == 10 (tolerant of int/float/string). Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node", "field_dim_length");
  $fc = FieldConfig::loadByName("node", "article", "field_dim_length");
  $len = $fc ? (array) $fc->getSetting("length") : [];
  $factor = $len["factor"] ?? NULL;
  $ok = ($fs && $fs->getType() === "length_field_type" && $fc && is_numeric($factor) && ((float) $factor) === 10.0);
  print ($ok ? "PASS" : "FAIL") . " type=" . ($fs ? $fs->getType() : "none") . " length.factor=" . var_export($factor, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
