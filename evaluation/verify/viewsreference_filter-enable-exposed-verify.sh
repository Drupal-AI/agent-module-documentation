#!/usr/bin/env bash
# Execution VERIFY: PASS when field_vrf_task's viewsreference field has exposed_filters in its
# enabled_settings. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node", "article", "field_vrf_task");
  $es = $fc ? array_filter((array) $fc->getSetting("enabled_settings")) : [];
  $ok = in_array("exposed_filters", array_values($es), TRUE) || array_key_exists("exposed_filters", $es);
  print ($ok ? "PASS" : "FAIL") . " enabled_settings=" . json_encode($es) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
