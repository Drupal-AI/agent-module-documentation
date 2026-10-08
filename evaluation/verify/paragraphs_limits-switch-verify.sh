#!/usr/bin/env bash
# Execution VERIFY: PASS when field_pl_switch uses the paragraphs_limits handler AND limits pl_text to a
# maximum of 3 (target_bundles_drag_drop.pl_text.upper_limit == 3). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node","article","field_pl_switch");
  $h = $fc ? $fc->getSetting("handler") : "none";
  $hs = $fc ? $fc->getSetting("handler_settings") : [];
  $max = $hs["target_bundles_drag_drop"]["pl_text"]["upper_limit"] ?? NULL;
  $ok = ($h === "paragraphs_limits" && (int) $max === 3);
  print ($ok ? "PASS" : "FAIL") . " handler=" . $h . " upper_limit=" . var_export($max, TRUE);
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
