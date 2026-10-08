#!/usr/bin/env bash
# Execution VERIFY: PASS when field_pl_max on Article limits pl_text to a maximum of 2
# (handler paragraphs_limits, target_bundles_drag_drop.pl_text.upper_limit == 2). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node","article","field_pl_max");
  $h = $fc ? $fc->getSetting("handler") : "none";
  $hs = $fc ? $fc->getSetting("handler_settings") : [];
  $max = $hs["target_bundles_drag_drop"]["pl_text"]["upper_limit"] ?? NULL;
  $ok = ($h === "paragraphs_limits" && (int) $max === 2);
  print ($ok ? "PASS" : "FAIL") . " handler=" . $h . " upper_limit=" . var_export($max, TRUE);
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
