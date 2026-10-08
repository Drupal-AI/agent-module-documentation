#!/usr/bin/env bash
# Execution VERIFY: PASS when field_pn_us is a phone_number field on node.article whose
# allowed_countries is exactly [US]. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node","article","field_pn_us");
  $type = $fc ? $fc->getType() : "none";
  $ac = $fc ? array_values($fc->getSetting("allowed_countries") ?: []) : [];
  $ok = $fc && ($type==="phone_number") && ($ac === ["US"]);
  print ($ok?"PASS":"FAIL")." type=".$type." allowed_countries=".implode(",",$ac)."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
