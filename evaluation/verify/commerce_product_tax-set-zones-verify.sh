#!/usr/bin/env bash
# Execution VERIFY: PASS when field_cpt_zones' allowed_zones setting includes the Germany zone
# ('de'). Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("commerce_product_variation","default","field_cpt_zones");
  $zones = $fc ? ($fc->getSetting("allowed_zones") ?: []) : [];
  $ok = $fc && in_array("de", $zones, TRUE);
  print ($ok ? "PASS" : "FAIL") . " field=" . ($fc ? "yes" : "no") . " allowed_zones=" . json_encode($zones) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
