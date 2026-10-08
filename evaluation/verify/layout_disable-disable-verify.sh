#!/usr/bin/env bash
# Execution VERIFY: PASS when layout_fourcol_section is disabled via layout_disable - it is listed in
# layout_disable.settings:disabled_layouts AND no longer discoverable by the layout plugin manager.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $disabled = \Drupal::config("layout_disable.settings")->get("disabled_layouts") ?: [];
  $in_config = in_array("layout_fourcol_section", array_keys($disabled)) || in_array("layout_fourcol_section", array_values($disabled));
  $m = \Drupal::service("plugin.manager.core.layout"); $m->clearCachedDefinitions();
  $gone = !$m->hasDefinition("layout_fourcol_section");
  $ok = ($in_config && $gone);
  print ($ok ? "PASS" : "FAIL") . " in_config=" . ($in_config?"yes":"no") . " removed_from_manager=" . ($gone?"yes":"no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
