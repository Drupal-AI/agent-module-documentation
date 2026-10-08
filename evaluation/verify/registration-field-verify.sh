#!/usr/bin/env bash
# Execution VERIFY: PASS when node.article has a field field_reg_event of type "registration".
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node", "field_reg_event");
  $fc = FieldConfig::loadByName("node", "article", "field_reg_event");
  $type = $fs ? $fs->getType() : "none";
  $ok = ($fs && $fc && $type === "registration");
  print ($ok ? "PASS" : "FAIL")." storage=".($fs?"yes":"no")." instance=".($fc?"yes":"no")." type=".$type."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
