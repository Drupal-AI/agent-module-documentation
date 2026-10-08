#!/usr/bin/env bash
# Execution VERIFY: PASS when layout_twocol has been RE-ENABLED - not present in
# layout_disable.settings:disabled_layouts AND discoverable again by the layout plugin manager.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $disabled = \Drupal::config("layout_disable.settings")->get("disabled_layouts") ?: [];
  $still = in_array("layout_twocol", array_keys($disabled)) || in_array("layout_twocol", array_values($disabled));
  $m = \Drupal::service("plugin.manager.core.layout"); $m->clearCachedDefinitions();
  $available = $m->hasDefinition("layout_twocol");
  $ok = (!$still && $available);
  print ($ok ? "PASS" : "FAIL") . " still_disabled=" . ($still?"yes":"no") . " available=" . ($available?"yes":"no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
