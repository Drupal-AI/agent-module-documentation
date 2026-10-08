#!/usr/bin/env bash
# Execution VERIFY: PASS when Article has an ISBN field field_isbn_build whose storage type
# is "isbn". Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node", "field_isbn_build");
  $fc = FieldConfig::loadByName("node", "article", "field_isbn_build");
  $type = $fs ? $fs->getType() : "none";
  $ok = ($fs && $fc && $type === "isbn");
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " field=" . ($fc ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
