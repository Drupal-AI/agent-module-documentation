#!/usr/bin/env bash
# Execution VERIFY: PASS when a field field_ld_task of type link_description exists as storage AND
# is attached to the Article bundle. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node", "field_ld_task");
  $fc = FieldConfig::loadByName("node", "article", "field_ld_task");
  $ok = $fs && $fs->getType() === "link_description" && $fc;
  print ($ok ? "PASS" : "FAIL") . " type=" . ($fs ? $fs->getType() : "none") . " onArticle=" . var_export((bool) $fc, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
