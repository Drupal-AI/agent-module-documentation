#!/usr/bin/env bash
# Execution VERIFY: PASS when Article has a field field_lf_task whose storage type is
# language_field (the languagefield field type) and a field instance on the article bundle.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node", "field_lf_task");
  $fc = FieldConfig::loadByName("node", "article", "field_lf_task");
  $type = $fs ? $fs->getType() : "none";
  $ok = ($fs && $fc && $type === "language_field");
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " instance=" . ($fc ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
