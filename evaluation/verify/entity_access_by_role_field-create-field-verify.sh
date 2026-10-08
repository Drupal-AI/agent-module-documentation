#!/usr/bin/env bash
# Execution VERIFY: PASS when Article has a field field_eabrf_new whose type is
# entity_access_by_role_field. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node","article","field_eabrf_new");
  $type = $fc ? $fc->getType() : "none";
  $ok = ($type === "entity_access_by_role_field");
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
