#!/usr/bin/env bash
# Execution VERIFY: PASS when field_fcc_h2 instance cardinality_config === '1'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  $fc = FieldConfig::loadByName("node", "fcc_h2", "field_fcc_h2");
  if (!$fc) { print "FAIL no field field_fcc_h2\n"; return; }
  $v = $fc->getThirdPartySetting("field_config_cardinality", "cardinality_config");
  $storage = FieldStorageConfig::loadByName("node", "field_fcc_h2");
  $scard = $storage ? $storage->getCardinality() : "none";
  $ok = ((string) $v === "1");
  print ($ok ? "PASS" : "FAIL") . " cardinality_config=" . var_export($v, TRUE) . " storage_cardinality=" . $scard . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
