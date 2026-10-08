#!/usr/bin/env bash
# Execution VERIFY: PASS when field_erv_task's FieldConfig carries
# third_party_settings.entity_reference_validators.circular_reference === TRUE. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node", "article", "field_erv_task");
  $v = $fc ? $fc->getThirdPartySetting("entity_reference_validators", "circular_reference", FALSE) : NULL;
  print (($v === TRUE || $v === 1 || $v === "1") ? "PASS" : "FAIL") . " circular_reference=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
