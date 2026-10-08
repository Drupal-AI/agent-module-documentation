#!/usr/bin/env bash
# Execution VERIFY: PASS when the 'default' product variation type has a field_cpt_task of type
# commerce_tax_rate whose tax_type setting is cpt_eu_vat. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("commerce_product_variation","default","field_cpt_task");
  $type = $fc ? $fc->getType() : "none";
  $tt = $fc ? $fc->getSetting("tax_type") : "";
  $ok = $fc && $type === "commerce_tax_rate" && $tt === "cpt_eu_vat";
  print ($ok ? "PASS" : "FAIL") . " field=" . ($fc ? "yes" : "no") . " type=" . $type . " tax_type=" . var_export($tt, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
