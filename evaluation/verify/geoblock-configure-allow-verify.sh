#!/usr/bin/env bash
# Execution VERIFY: PASS when geoblock.settings restriction_type == 'allow' and
# restriction_country_codes contains both US and CA. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("geoblock.settings");
  $type = $c->get("restriction_type");
  $codes = $c->get("restriction_country_codes") ?: [];
  $ok = ($type === "allow" && in_array("US", $codes, TRUE) && in_array("CA", $codes, TRUE));
  print ($ok ? "PASS" : "FAIL") . " type=" . var_export($type, TRUE) . " codes=" . implode(",", $codes) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
