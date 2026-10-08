#!/usr/bin/env bash
# Execution VERIFY for the migrate case: PASS when field_mlmm_mig's storage type has become
# entity_reference_entity_modify. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  $fs = FieldStorageConfig::loadByName("node", "field_mlmm_mig");
  $type = $fs ? $fs->getType() : "none";
  $ok = ($type === "entity_reference_entity_modify");
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
