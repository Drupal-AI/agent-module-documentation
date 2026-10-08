#!/usr/bin/env bash
# HARD VERIFY: PASS when Article has a field named field_eh_task whose field type is
# entity_reference_hierarchy. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node", "article", "field_eh_task");
  $type = $fc ? $fc->getType() : "none";
  $ok = ($type === "entity_reference_hierarchy");
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
