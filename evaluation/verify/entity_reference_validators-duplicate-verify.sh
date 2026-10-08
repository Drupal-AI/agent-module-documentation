#!/usr/bin/env bash
# Execution VERIFY: PASS when field_erv_multi's FieldConfig carries
# third_party_settings.entity_reference_validators.duplicate_reference === TRUE. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node", "article", "field_erv_multi");
  $v = $fc ? $fc->getThirdPartySetting("entity_reference_validators", "duplicate_reference", FALSE) : NULL;
  print (($v === TRUE || $v === 1 || $v === "1") ? "PASS" : "FAIL") . " duplicate_reference=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
